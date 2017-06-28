#!/usr/bin/env bash

function usage {
  cat <<EOL
USAGE: ${0} CN OU O L ST [C=GB] [E]

  CN: The 'common name', a descriptive name of your client / organisation

  OU: The organisational unit name
      e.g. GRO

  O:  The organisation
       e.g. HMPO

  L:  The locality name
      e.g. Southport

  ST: The state or province name
      e.g. Merseyside

  C:  The country name (defaults to GB)

  E:  An optional e-mail address associated with your certificate
EOL
}

CN="${1}"
OU="${2}"
O="${3}"
L="${4}"
ST="${5}"
C="${6:-GB}"
if [ ${#6} -gt 2 ]; then
  C="GB"
  E="${6}"
else
  E="${7}"
fi

function check_arg {
  if [ -z "${1}" ]; then
    echo "Error: Missing ${2} in arguments";
    echo
    usage
    exit 1;
  fi
}

check_arg "${CN}" "CN"
check_arg "${OU}" "OU"
check_arg "${O}" "O"
check_arg "${L}" "L"
check_arg "${ST}" "ST"

if [ ! -z ${E} ]; then
  E_LONG="/E=${E}"
fi

SUBJ="/C=${C}/ST=${ST}/L=${L}/O=${O}/OU=${OU}/CN=${CN}${E_LONG}"

echo "Producing CSR / Private key pair for \"${SUBJ}\"..."

openssl genrsa -out client.key 4096
openssl req -new -key client.key -sha256 -subj "${SUBJ}" -out client.csr
