email = prompt.ask('Your git email')
`git config --global user.email "#{email}"`

name = prompt.ask('Your git name')
`git config --global user.name "#{name}"`

autocorrect = prompt.yes?('Turn on autocorrect')
`git config --global help.autocorrect #{autocorrect ? 1 : 0}`

editor = promtp.ask('Default editor command?(atom --wait, subl -n -w, vim)')
`git config --global core.editor "#{editor}"`

`git config --global push.default current`
