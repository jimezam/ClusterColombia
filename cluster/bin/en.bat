SET NAME=en

SET VAGRANT_VAGRANTFILE=vagrantfiles/%NAME%.vagrantfile 
SET VAGRANT_DOTFILE_PATH=vagrantfiles/.vagrant_%NAME% 

vagrant %1 %2 %3 %4 %5
