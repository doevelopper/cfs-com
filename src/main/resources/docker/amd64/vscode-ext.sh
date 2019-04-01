for ext in $(echo -e """aeschli.vscode-css-formatter
                        batisteo.vscode-django
                        christian-kohler.path-intellisense
                        CodeStream.codestream
                        DavidAnson.vscode-markdownlint
                        dbaeumer.vscode-eslint
                        donjayamanne.jupyter
                        donjayamanne.python-extension-pack
                        DotJoshJohnson.xml
                        DSKWRK.vscode-generate-getter-setter
                        emilast.LogFileHighlighter
                        Entomy.ada
                        Equinusocio.vsc-material-theme
                        formulahendry.code-runner
                        formulahendry.terminal
                        glen-84.sass-lint
                        GrapeCity.gc-excelviewer
                        jasonnutter.search-node-modules
                        magicstack.MagicPython
                        mitaki28.vscode-clang
                        mohsen1.prettify-json
                        ms-python.anaconda-extension-pack
                        ms-python.python
                        ms-toolsai.vscode-ai
                        ms-vscode.azure-account
                        ms-vscode.cpptools
                        ms-vscode.csharp
                        ms-vsliveshare.vsliveshare
                        PKief.material-icon-theme
                        rogalmic.bash-debug
                        sdras.vue-vscode-snippets
                        shardulm94.trailing-spaces
                        sidthesloth.html5-boilerplate
                        slevesque.vscode-hexdump
                        slevesque.vscode-zipexplorer
                        Tyriar.shell-launcher
                        vector-of-bool.cmake-tools
                        VisualStudioExptTeam.vscodeintellicode
                        waderyan.nodejs-extension-pack
                        wayou.vscode-todo-highlight
                        wholroyd.jinja""" | tr -s ' ' | tr ' ' '\n' ); do
  /usr/bin/code --install-extension $ext;
done

