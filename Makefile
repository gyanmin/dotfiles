
CPOPT = -r
ifdef force
  ifeq ($(force),1)
	CPOPT+=f
  endif
endif

.PHONY : all bspwm sxhkd dunst vim vimperator ranger mutt mpd 

all: bspwm sxhkd dunst ranger vim vimperator xresources mpd newsbutter

submodule:
	git submodule update --init

bspwm:
	cp $(CPOPT) $(CURDIR)/bspwm ~/.config/

sxhkd:
	cp $(CPOPT) $(CURDIR)/sxhkd ~/.config/

xresources:
	cp $(CPOPT) $(CURDIR)/xresources ~/.config/

dunst:
	cp $(CPOPT) $(CURDIR)/dunst ~/.config/

ranger:
	cp $(CPOPT) $(CURDIR)/ranger ~/.config/

vim: submodule
	cp $(CPOPT) $(CURDIR)/vim ~/.config/
	ln -s ~/.config/vim/vimrc ~/.vimrc
	vim -c "BundleInstall"

vimperator:
	cp $(CPOPT) $(CURDIR)/vimperator ~/.vimperator

mutt:
	cp $(CPOPT) $(CURDIR)/mutt ~/.config/
	ln -s ~/.config/mutt ~/.mutt

newsbutter:
	cp $(CPOPT) $(CURDIR)/newsbutter ~/.config/

mpd:
	cp $(CPOPT) $(CURDIR)/mpd ~/.config/

