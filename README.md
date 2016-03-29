# Format JS vim

Simple (a.k.a. hack) bridge that calls out to [format-js-cli](https://github.com/gillesruppert/format-js-cli).

This formats JS and adds `require` and `import type` for flow that are used in
the file. See the [original source code](https://github.com/facebook/nuclide/tree/master/pkg/nuclide-format-js-base) in the nuclide repo.

## Settings

You can add the following settings to your vimrc:

```
" Set any built in classes that will be ignored
let g:formatjs_builtins='Promise,setTimeout'

" Set any built in types that will be ignored
let g:formatjs_builtintypes='Promise,ReactClass'

" Any aliases to use, format is in csv pairs
let g:formatjs_aliases='Original,NewName'
```
