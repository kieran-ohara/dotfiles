# grep --
{:data-section="shell"}
{:data-date="March 09, 2019"}
{:data-extra="Um Pages"}

## SYNOPSIS


## DESCRIPTION


## OPTIONS

`-F`
: Force grep to behave as fgrep; does not interpret regular expressions.

`-x`
: Only input lines selected against an entire fixed string or regex are
considered matching

`-q`
: Quiet; suppress normal output. Grep will search until a match has been found,
making searches less expensive.


## EXIT STATUS

Grep exits with the following values:

`0`
: One or more lines were selected

`1`
: No lines were selected.

`-1`
: An error occurred.
