tools=(
  "ansible-playbook"
  "ansible"
  "cw"
  "hurl"
  "jq"
  "kubectl"
  "lefthook"
  "make"
  "ncdu"
  "packer"
  "rg"
  "tree"
)
for tool in "${tools[@]}"
do
  alias $tool="() { pkgx +$tool $tool \"\$@\" }"
done

alias http='() { pkgx +httpie http "$@" }'
