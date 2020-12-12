### This is a github setup proceture

#### Install github

- Linux [ubuntu]
```
$ apt install git
```
...


#### Setup SSH

- Check ssh existance

```
# should see a list of files if ssh exist, otherwise coninue
$ ls -al ~/.ssh
```

- Generate a new SSH key

```
# -t: specifies the type of key to be generated
# -C: specifies changing the key comment to a new comment

ssh-keygen -t ed25519 -C "your_github_email@example.com"
```

#### Adding your SSH key to the ssh-agent

- Start the ssh-agent in the background
```
# -s: Generate Bourne shell commands on stdout
$ eval "$(ssh-agent -s)"
>>> Agent pid 123445
```

- Add your SSH private key to the ssh-agent
```
$ ssh-add ~/.ssh/id_ed25519
```

- Copy the SSH public key to your clipboard

```
$ xclip -selection clipboard < ~/.ssh/ed25519.pub
```

- complete the setup using this [link](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)
