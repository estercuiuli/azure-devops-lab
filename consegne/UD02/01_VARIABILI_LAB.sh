export LAB_LOCATION="italynorth"
export LAB_SUFFIX="c8721f83"
export LAB_RG="rg-cea-ud02-${LAB_SUFFIX}"
export LAB_VNET="vnet-cea-ud02"
export LAB_SUBNET="snet-app"
export LAB_STORAGE="stcea${LAB_SUFFIX}" #lbstrg
export LAB_DELETE_AFTER="$(date -d '+2 days' +%F)"

if [[ "$LAB_STORAGE" =~ ^[a-z0-9]{3,24}$ ]]; then
  printf 'Nome storage formalmente valido.\n'
else
  printf 'Nome storage non valido: usare 3-24 caratteri minuscoli o numerici.\n'
fi