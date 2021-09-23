#!/usr/bin/env bash
set -e
set -o pipefail

_PURGE_COMMAND=$1
_PURGE_REF=$2

if [[ ${_PURGE_COMMAND} != "delete" ]] && [[ ${_PURGE_COMMAND} != "invalidate" ]]
then
  echo "Unknown command '${_PURGE_COMMAND}' ... exiting"
  exit 123
fi

# case ${_PURGE_TYPE} in
#   cpcode)
#     _CLI_OPT="--cpcode"
#   ;;

#   tag)
#     _CLI_OPT="--tag"
#   ;;

#   *)
#     echo "Unknown type '${_PURGE_TYPE}' ... exiting"
#     exit 123
#   ;;
# esac

# Create /root/.edgerc file from env variable
echo -e "${AKAMAI_SECRET}" > /root/.edgerc

# Send purge request
/usr/local/bin/purge \
  --edgerc /root/.edgerc \
  --section default \
  ${_PURGE_COMMAND} \
 "${_PURGE_REF}"
