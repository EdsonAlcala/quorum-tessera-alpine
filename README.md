# Quorum-tessera-alpine

This Docker image contains [Quorum](https://github.com/jpmorganchase/quorum), [Tessera](https://github.com/jpmorganchase/tessera) and I also included the [Istanbul tools](https://github.com/jpmorganchase/istanbul-tools) 
that can be used to generate the extra data field of the genesis when we want to run Quorum with [Istanbul](https://github.com/ethereum/EIPs/issues/650).

The Docker image is built using multi-stage builds that also improve readibility.

## Commands

> docker pull <>:quorum-tessera-alpine

If you want to build the image locally

> git clone https://github.com/EdsonAlcala/quorum-tessera-alpine

> docker build -t quorum-tessera-alpine .

## References

https://github.com/jpmorganchase/quorum/wiki/From-Scratch

https://docs.docker.com/develop/develop-images/multistage-build/
