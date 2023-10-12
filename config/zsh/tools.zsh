tools=(
  "ansible-playbook"
  "ansible"
  "cw"
  "gh"
  "git-branchless"
  "git"
  "glab"
  "hurl"
  "jq"
  "kubectl"
  "lefthook"
  "make"
  "ncdu"
  "packer"
  "rg"
  "tree"
  "zoxide"
)
for tool in "${tools[@]}"
do
  alias $tool="() { pkgx +$tool $tool \"\$@\" }"
done

alias http='() { pkgx +httpie http "$@" }'
