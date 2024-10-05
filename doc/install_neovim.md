# install dependencies  
## Install dependencies for neovim  
```sh
sudo dnf copr enable atim/lazygit -y
sudo dnf install -y cmake python3-pip lazygit cargo clang pkg-config openssl-devel chafa luarocks ripgrep fd-find xsel 
# sudo dnf install -y nodejs python3
```  
alternative install chafa  
```sh
sudo dnf install -y autoconf automake libtool glib2-devel freetype-devel
git clone https://github.com/hpjansson/chafa.git --branch=1.12.0 && cd chafa
./autogen.sh
make
sudo make install
```

## Create links  
```sh
cd /usr/bin && sudo ln -s clang-tidy-sarif clang-tidy && cd
mkdir -p ~/.local/share/nvim/lazy-rocks/hererocks/bin
cd ~/.local/share/nvim/lazy-rocks/hererocks/bin && \
	sudo ln -s /usr/bin/lua lua && \
	sudo ln -s /usr/bin/luarocks luarocks 
```  

## Install npm plugins and add path  
```sh
npm install tree-sitter-cli
sudo npm install -g neovim
```  
change path to .bashrc or .zshrc  
export PATH=$HOME/node_modules/.bin:$HOME/.local/bin:$PATH  

## Install clangd config  
```sh
mkdir -p ~/.config/clangd && /
	cd ~/.config/clangd
nano config.yaml
```
add in config.yaml following config:  
CompileFlags:  
	Add: [-std=c++23]  

## Install nerd-font for neovim  
https://www.nerdfonts.com/font-downloads  
download any font and unpack it into .fonts  
```sh
mkdir ~/.fonts
```  

# Install neovim  
version not lower than 0.10.0  
```sh
sudo dnf install -y neovim
```  
alternative install neovim  
https://github.com/neovim/neovim/blob/master/BUILD.md#quick-start  
