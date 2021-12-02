#!/bin/bash

# ====
USERID=`id -u`
USERGROUP=`id -g`

DOCKER_USERID=${DOCKER_USERID:-$USERID:$USERGROUP}
DOCKER_USERID_ARG=${DOCKER_USERID_ARG:--u ${DOCKER_USERID}}

PATH_PROJECT=${PATH_PROJECT:-.}
pushd "${PATH_PROJECT}" &>/dev/null || return $? # On error, return error code
PATH_PROJECT=`pwd -P`
popd &> /dev/null

echo "===="
echo "Running as User : ${USERID}:${USERGROUP}"
echo "Path Project    : ${PATH_PROJECT}"
# ====

timestamp() {
    echo `date "+%Y-%m-%d %H:%M:%S"`
}

buildAssets()
{
    echo "===="
    echo "Building 'assets' ..."

    # Mingrammer will be generated in below folder
    mkdir -p ${PATH_PROJECT}/build/adoc/assets

    if [ -e ${PATH_PROJECT}/build/adoc/assets/*.py ]; then
        docker run ${DOCKER_USERID_ARG} --rm \
            -v ${PATH_PROJECT}:/project \
            -w /project/src/main/adoc/assets \
            kalemena/mingrammer-diagrams:latest bash \
                -c 'for FILE in *.py; do python ${FILE}; done && pwd && ls -la && mv *.png /project/src/main/adoc/images/'
    fi

    echo "===="
}

publishConfluence()
{
    echo "===="
    echo "Publishing to Confluence ..."
    docker run ${DOCKER_USERID_ARG} --rm \
        --env-file .env-confluence \
        --network docs_default \
        -e ATTRIBUTES="{ \"confluencePublisherVersion\": \"0.0.0-SNAPSHOT\"}" \
        -v ${PATH_PROJECT}:/project \
        confluencepublisher/confluence-publisher:0.0.0-SNAPSHOT
    echo "===="
}

publishPDF()
{
    # PlantUML will be generated in below folder
    mkdir -p ${PATH_PROJECT}/build/adoc/assets

    REVISION=${REVISION:-latest}

    for FILE in ${PATH_PROJECT}/src/main/adoc/_*Book.adoc; do 
        echo "===="
        FILENAME=$(/usr/bin/basename "${FILE}")
        echo "Publishing to PDF ... ${FILENAME}"

        docker run ${DOCKER_USERID_ARG} --rm --name docsbuild \
            -v ${PATH_PROJECT}:/project \
            asciidoctor/docker-asciidoctor \
            asciidoctor-pdf \
                -a allow-uri-read \
                -a icons=font \
                -a imagesoutdir=/project/build/adoc/assets \
                -r asciidoctor-diagram \
                -D /project/src/main/adoc -B /project/src/main/adoc \
                /project/src/main/adoc/${FILENAME}
        # -a pdf-style=/docs/themes/advanced-theme.yml
        echo "===="
    done

    mv ${PATH_PROJECT}/src/main/adoc/_*-Book.pdf ${PATH_PROJECT}/build/adoc/
}

publishHTML()
{
    # PlantUML will be generated in below folder
    mkdir -p ${PATH_PROJECT}/build/adoc/assets
    mkdir -p ${PATH_PROJECT}/build/adoc/html/images

    REVISION=${REVISION:-latest}

    for FILE in ${PATH_PROJECT}/src/main/adoc/_*Book.adoc; do 
        echo "===="
        FILENAME=$(/usr/bin/basename "${FILE}")
        echo "Publishing to HTML ... ${FILENAME}"

        docker run ${DOCKER_USERID_ARG} --rm --name docsbuild \
            -v ${PATH_PROJECT}:/project \
            asciidoctor/docker-asciidoctor \
            asciidoctor \
                -a data-uri \
                -a allow-uri-read \
                -a icons=font \
                -a source-highlighter=highlightjs \
                -a ghlightjs-theme=gruvbox-dark \
                -a imagesoutdir=/project/build/adoc/assets \
                -a toc=left \
                -a docinfo=shared \
                -a favicon=images/favicon.png \
                -r asciidoctor-diagram \
                /project/src/main/adoc/${FILENAME}
        echo "===="
    done

    # This is embedded into docinfo.html
    #-a stylesheet=asciidoctor.css \                 -a stylesdir=themes \                 -a linkcss=true \
    # cp ${PATH_PROJECT}/src/main/adoc/themes/*.css ${PATH_PROJECT}/build/adoc/themes/

    cp ${PATH_PROJECT}/src/main/adoc/images/favicon.png ${PATH_PROJECT}/build/adoc/html/images/
    mv ${PATH_PROJECT}/src/main/adoc/_*Book.html ${PATH_PROJECT}/build/adoc/html/
    touch ${PATH_PROJECT}/build/adoc/html/.nojekyll
}