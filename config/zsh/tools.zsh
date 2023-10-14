tools=(
  "ansible-playbook"
  "ansible"
  "cw"
  "hurl"
  "kubectl"
  "lefthook"
  "make"
  "ncdu"
  "packer"
  "tree"
)
for tool in "${tools[@]}"
do
  alias $tool="() { pkgx +$tool $tool \"\$@\" }"
done

alias http='() { pkgx +httpie http "$@" }'
