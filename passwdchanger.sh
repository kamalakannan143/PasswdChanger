
#!/bin/bash
#cat /etc/shadow      #replaces the test as /etc/shadow

echo -e '\n\n\t\t IT REQUIRES "SUDO" MODE FOR THE STANDARD USER IF IT WAS IN "ROOT" USER DONT NEED .... Example: sudo ./pass_changer.sh\n\n'
read -p "Type the username to reset the password(case sensitive)" usr   #NAME OF THE USER
echo "Enter the change password: "    # PLAIN TEXT PASSWORD
python3 -c "import crypt; root=input(''); print(crypt.crypt(root))" > ingo     #CRYPT HASH IN SHA 256
echo -e "$(< /etc/shadow)\n" | sudo grep $usr | sudo cut -d ':' -f 3-  > rsa    #GET THE USERDATA AND CUT THE USER ID AFTER THE HASH IN ORGINAL FILE
sed -i "/$usr/d" /etc/shadow
echo $usr:"$(< ingo)":"$(< rsa)" >> /etc/shadow         ##to change the directory path as /etc/shadow
echo -e "\n\t\t\t\tPASSWORD CHANGED SUCCESSFULLY \n"
rm -rf rsa ingo
