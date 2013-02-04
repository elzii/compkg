#!/bin/bash

# INTRO 
# ==============================================
echo -e "\033[1;37;42m                                              \033[1;37;40m"
echo -e "\033[1;37;42m     \033[1;36;42mcompkg.sh\033[1;37;42m - search packagist via \033[33mjshon\033[37m   \033[1;37;40m"
echo -e "\033[1;37;42m                                              \033[1;37;40m"

# DEFAULTS
#===============================================
COMPKGTMPDIR=".compkg-temp"
COMPKGTMPDIRPATH="/Users/`whoami`/$COMPKGTMPDIR"
COMPKGTMPFILE="compkg-json-results.json"
PACKGISTSEARCHURL="https://packagist.org/search.json?tags="

	#JSHON VARS
	#======================================
	JSHONARGS="-e results -e 0 -e name"

	#CHMOD VARS
	#======================================
	CHMODARGS="777"


# CONFIG
#===============================================
mkdir -p "$COMPKGTMPDIRPATH"
echo ""
echo -e "\033[1;30m-------------------------------------------------------------------------------\033[1;37m"
echo -e "\033[1;30mCONFIG >> created directory ~/$COMPKGTMPDIR \033[1;37m"
echo -e "\033[1;30m-------------------------------------------------------------------------------\033[1;37m"


# FUNCTIONS
#=========================================
compkg_query () {
	echo -ne "search packagist.org for? > "; read PKGQUERY
	if [[ "$PKGQUERY" = "" ]] ; then
		echo -ne "\033[31mwhoops\033[37m, you didn't search anything -- "
   		compkg_query
	else
		echo -e "\033[1;30m-------------------------------------------------------------------------------\033[1;37m"
		echo -e "\033[32mrad\033[37m >> searching packagist.org for \033[35m$PKGQUERY\033[37m"
		echo -e "\033[1;30m-------------------------------------------------------------------------------\033[1;37m"
		compkg_curl
	fi
}
compkg_curl () {
	echo -e "storing cURL results into \033[1;30m$COMPKGTMPFILE\033[1;37m ... "
	echo -e "\033[1;30m-------------------------------------------------------------------------------\033[1;37m"
	curl -s "$PACKGISTSEARCHURL$PKGQUERY" > "$COMPKGTMPDIRPATH/$COMPKGTMPFILE"	
	cd "$COMPKGTMPDIRPATH";chmod "$CHMODARGS" "$COMPKGTMPDIRPATH/$COMPKGTMPFILE"
	compkg_jshon
}
compkg_jshon () {
	#echo -n "jshon $JSHONARGS < $COMPKGTMPDIRPATH/$COMPKGTMPFILE"
	echo -ne "how many results to display? [DEFAULT = 10]> "; read QUERYCOUNT
	echo ""

	if [[ "$QUERYCOUNT" = "" ]] ; then
		DISPLAYCOUNT="10"
	else 
		DISPLAYCOUNT="$QUERYCOUNT"
	fi

	x=0
	while [ $x -le $DISPLAYCOUNT ]
	do
		#jshon -e results -e $x -e name -u -i n -e description -u < "$COMPKGTMPFILE"
	  	echo -e "\033[1;31m" | tr "\\n" " "
	  	export pkg$x=`jshon -e results -e $x -e name -u < "$COMPKGTMPFILE"`; echo pkg$x | tr "\\n" " "
	  	echo -e "\033[36m" | tr "\\n" " "
	  	jshon -e results -e $x -e name -u < "$COMPKGTMPFILE" | tr "\\n" " "
	  	echo -e "\033[37m" | tr "\\n" " "
	  	jshon -e results -e $x -e description -u < "$COMPKGTMPFILE"
	  	x=$(( $x + 1 ))
	done
	echo ""
	compkg_clean
}

compkg_clean () {
	echo -ne "\033[1;30mcleaning up $COMPKGTMPDIRPATH/$COMPKGTMPFILE ... \033[32mCOMPLETE\033[1;37m"
	rm "$COMPKGTMPDIRPATH/$COMPKGTMPFILE"
	echo ""
	echo ""
}

# EXECUTE FIRST FUNCTION
#=========================================
compkg_query




