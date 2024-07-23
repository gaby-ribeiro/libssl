# syntax=docker/dockerfile:1
FROM gabyribeiro/product-x:recommended AS base-image
WORKDIR /ws
RUN --mount=type=bind,source=changed.txt,target=/preload/changed.txt \
    cat /preload/changed.txt | xargs -r -i rm -rf /ws/{}

FROM base-image AS run-image
ENTRYPOINT [ "/bin/bash" ]

# TO build the devbuild image:
# docker build --no-cache --progress plain --target run-image -t gabyribeiro/product-x:devbuild . 

# To run it for monolitic build:
# docker run -it \
#   -v .:/ws/libssl \      <-- self repository
#   -v .complementary-comps/libgl2:libgl2     <--- other repos with the same deliver-id where it differs from foundation/merge-base
#   gabyribeiro/product-x:devbuild    

# TODO: generate changed.txt from a previous gh action, sideload the other necessary delivery-id contributors.
