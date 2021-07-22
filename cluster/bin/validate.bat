SET NAME=%1

SET VAGRANT_VAGRANTFILE=vagrantfiles/%NAME%.vagrantfile 
SET VAGRANT_DOTFILE_PATH=vagrantfiles/.vagrant_%NAME% 

vagrant validate %2 %3 %4 %5
