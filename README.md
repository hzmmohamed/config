Other configs I referenced
- https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
- https://github.com/MatthiasBenaets/nixos-config
- https://github.com/LunNova/nixos-configs

Other references:
- https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html#implementation
- https://github.com/drduh/config




## Resources

- Other Configs:
    - https://github.com/KubqoA/dotfiles
    - https://github.com/hlissner/dotfiles
    - https://github.com/jakehamilton/config
    - https://codeberg.org/sena/nixfiles-old
    - https://github.com/xenoxanite/flakes
    - https://codeberg.org/imMaturana/dotfiles/src/branch/main/home/features/nvim/default.nix



Spotify/Chromium or other Electron apps might stop working when changing configs, then you'll have to find the SingletonLock file and delete it. ([Ref](https://www.reddit.com/r/Fedora/comments/1di4fbk/comment/l922sf7/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button))

`rm -rf ~/.cache/spotify/Singleton*`
`rm -rf ~/.config/chromium/Singleton*`



### Zotero Config
Currently, there's no established method for configuring Zotero decalratively. In the meantime, I'm documentating my configuration here:

- Plugins
    - Better BibTex
    - zoplicate
    - zotero style
    - zotero reading status
    - zotero categorical tags

    - Zotero Actions & Tags (disabled)


    
Current workflow questions I have:
- What do I actually use collections for? I currently have Inbox, Up Next, and Read. I'd rather use tags for read and unread status. Maybe a collection for "Up Next". What do people usually use collections for? Is there a plugin to automatically manage the collections? Are collections completely separate namespaces? What are the pros and cons for separate collections vs. one big collection?



## Remote Installation
https://github.com/nix-community/nixos-anywhere/blob/main/docs/howtos/secrets.md#example-uploading-disk-encryption-secrets