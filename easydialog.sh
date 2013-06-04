#!/usr/bin/env bash
#
#########################
#
# Copyright (C) 2013 Vittorio Cagnetta
#
# Author: Vittorio Cagnetta <vaisarger@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program, 
# called, in this distribution, "EasyBashGUI-license"; if not, write to the 
# Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
#
#########################
#
############################
#
#
#
usage()
	{
	#
	echo -e "Usage:>$(basename "${0}" ) [-m [mode]] [box type] <box options>" 
	echo -e "\t1)Where [modes] are:" 
	echo -e "\t a \t\t=>\t automatic (normal way)"
	echo -e "\t g \t\t=>\t to force gtkdialog"
	echo -e "\t k \t\t=>\t to force kdialog"
	echo -e "\t z \t\t=>\t to force zenity"
	echo -e "\t x \t\t=>\t to force Xdialog"
	echo -e "\t d \t\t=>\t to force (c)dialog"
	echo -e "\t n \t\t=>\t to force no widget ( => shell boxes)"
	echo -e "\n"
	echo -e "\tAnd [box types] -> [box options] are:" 
	echo -e "\t --question -> \"[text]\" \t\t=>\t ( 1 argument, box output to exit code and STDERR )"
	echo -e "\t --message -> \"[text]\" \t\t\t=>\t ( 1 argument )"
	echo -e "\t --alert_message -> \"[text]\" \t\t=>\t ( 1 argument )"
	echo -e "\t --ok_message -> \"[text]\" \t\t=>\t ( 1 argument )"
	echo -e "\t --text \t\t\t\t=>\t ( STDIN, NO argument, box output to \"\${dir_tmp}/\${file_tmp}\" and STDERR )"
	echo -e "\t --wait_seconds -> \"[integer]\" \t\t=>\t ( 1 argument )"
	echo -e "\t --wait_for -> \"[text]\" \t\t=>\t ( 1 argument, PID to kill to \"wait_for__PID\" variable and STDERR )"
	echo -e "\t --terminate_wait_for \t\t\t=>\t ( 1 argument only in $(basename "${0}" ), otherwise, NO argument )"
	echo -e "\t --fselect -> \"<init. dir.>\" \t\t=>\t ( 1 <optional> argument, box output to \"\${dir_tmp}/\${file_tmp}\" and STDERR )"
	echo -e "\t --dselect -> \"<init. dir.>\" \t\t=>\t ( 1 <optional> argument, box output to \"\${dir_tmp}/\${file_tmp}\" and STDERR )"
	echo -e "\t --input -> 1 \"[init 1]\" \t\t=>\t ( 2 arguments, box output to \"\${dir_tmp}/\${file_tmp}\" and STDERR )"
	echo -e "\t --input -> 2 \"[label 1]\" \"[init 1]\" \"[label 2]\" \"[init 2]\" \t\t\t=> ( 5 arguments, box output to \"\${dir_tmp}/\${file_tmp}\" and STDERR )"
	echo -e "\t --input -> 3 \"[label 1]\" \"[init 1]\" \"[label 2]\" \"[init 2]\" \"[label 3]\" \"[init 3]\" => ( 7 arguments, box output to \"\${dir_tmp}/\${file_tmp}\" and STDERR )"
	echo -e "\t --menu -> \"[item 1]\" ... \"[item n]\" \t=>\t ( [n] arguments, box output to \"\${dir_tmp}/\${file_tmp}\" and STDERR )"
	echo -e "\t --list -> <+|->\"[item 1]\" ... <+|->\"[item n]\" \t=>\t ( [n] arguments, optionally prefixed with \"+\"(plus) or \"-\"(minus), box output to \"\${dir_tmp}/\${file_tmp}\" and STDERR )"
	echo -e "\t --progress -> \"[text]\" \t\t\t=>\t ( STDIN -percent-, 1 argument )"
	echo -e "\t --progress -> \"[text]\" \"[elements number]\" \t=>\t ( STDIN -\"PROGRESS\"-, 2 arguments )"
	echo -e "\t --adjust -> \"[text]\" \"[min value]\" \"[init value]\" \"[max value]\" \t=>\t ( 4 arguments, box output to \"\${dir_tmp}/\${file_tmp}\" and STDERR )"
	echo -e "\n\n"
	echo -e "\t2)Examples:"
	echo -e "\t>$(basename "${0}" ) -m a --question \"Do you like Contry music ?\" 2> a.txt ; a=\"\$(0< a.txt )\" ; rm -f a.txt ; [ \${a} -eq 0 ] && $(basename "${0}" ) -m a --ok_message \"You do like it :)\" || $(basename "${0}" ) -m a --alert_message \"You don't like it :(\" "
	echo -e "\t>echo -e \"What's your name?\\\n\\\nMy name's:\\\nVittorio\" | $(basename "${0}" ) -m z --text"
	echo -e "\t>$(basename "${0}" ) -m a --wait_seconds 3"
	echo -e "\t>$(basename "${0}" ) -m k --wait_for \"I'm sleeping 4 seconds... good night...\" 2> pid.txt ; pid=\"\$(0< pid.txt )\" ; rm -f pid.txt ;    sleep 4    ; $(basename "${0}" ) -m k --terminate_wait_for \"\${pid}\" "
	echo -e "\t>$(basename "${0}" ) -m x --fselect"
	echo -e "\t>$(basename "${0}" ) -m a --input 1 \"(write here IP address)\""
	echo -e "\t>$(basename "${0}" ) -m k --input 3 \"Username\" \"root\" \"IP address\" \"192.168.0.1\" \"Destination directory\" \"/tmp\""
	echo -e "\t>$(basename "${0}" ) -m d --menu \"Country\" \"Blues\" \"Rock\""
	echo -e "\t>for i in 10 20 30 40 50 60 70 80 90 100 ; do echo \"\${i}\" && sleep 2 ; done | $(basename "${0}" ) -m d --progress \"This is a test progress...\""
	echo -e "\t>for i in 10 20 30 40 50 60 70 80 90 100 ; do echo \"PROGRESS\" && sleep 2 ; done | $(basename "${0}" ) -m z --progress \"This is a test progress...\" \"10\""
	echo -e "\n\n"
	echo -e "\t3)Would you like *really* easy dialogs?"
	echo -e "\tTry this:"
	echo -e "\t>cp easybashgui /usr/local/bin/"
	echo -e "\t>touch \"easy_updatedb.sh\""
	echo -e "\t>chmod 755 \"easy_updatedb.sh\""
	echo -e "\tThen, edit the file like so:"
	echo -e "\t"
	echo -e "\t#!/usr/bin/env bash"
	echo -e "\tsource /usr/local/bin/easybashgui"
	echo -e "\tmessage \"Click OK \\\n to update locate db...\""
	echo -e "\twait_for \"Updating...\" ; updatedb ; terminate_wait_for"
	echo -e "\tok_message \"Update finished ;-)\""
	echo -e "\t"
	echo -e "\tTry to launch the *same* script in console, in GNOME, in KDE, and finally in text console... ;-)"
	echo
	#
	exit 1
	#
	} 1>&2
#
#
#
############################
#
#
#
[ ${#} -eq 0 ] && usage
while getopts ":hvm:" option
	do
	case ${option} in
	 "h" )
		source easybashgui ; \
		echo -e "\nThe library \"${LIB_NAME}\" allows bash scripters to simply provide their scripts a graphical user interface in an easy way: no matter wich dialog type is more appropriate ( if you are in GNOME, in KDE, etc.).\nThe script ( \"$(basename "${0}" )\" ) is used only to show ${LIB_NAME} library capability...\n\n" 1>&2 && usage \
		;;
	 "v" )
		source easybashgui ; \
		echo -e "\n${LIB_NAME}: vers. ${LIB_VERSION}\n" 1>&2 && exit \
		;;
	 "m" )
		if [ "${OPTARG}" = "a" ]; then export supermode="auto" && break ; \
		elif [ "${OPTARG}" = "g" ]; then export supermode="gtkdialog" && break ; \
		elif [ "${OPTARG}" = "k" ]; then export supermode="kdialog" && break ; \
		elif [ "${OPTARG}" = "z" ]; then export supermode="zenity" && break ; \
		elif [ "${OPTARG}" = "x" ]; then export supermode="Xdialog" && break ; \
		elif [ "${OPTARG}" = "d" ]; then export supermode="dialog" && break ; \
		elif [ "${OPTARG}" = "n" ]; then export supermode="none" && break ; \
		else usage ; \
		fi \
		;;
	 * )
		usage \
		;;
	esac
	#
done
shift $(($OPTIND - 1))
#
#
#
funct="$(echo "${1}" | tr -d '-' )"
case ${funct} in
	"question"|\
	"message"|"alert_message"|"ok_message"|\
	"text"|\
	"wait_seconds"|"wait_for"|"terminate_wait_for"|\
	"fselect"|"dselect"|\
	"input"|\
	"menu"|"list"|\
	"progress"|\
	"adjust" )
		:;;
	
	* )
		usage ;;
esac && shift
#
#
#
############################
# ...main
LIB_CHECK="$(type "easybashgui" 2> /dev/null )" ; [ ${#LIB_CHECK} -eq 0 ] && echo -e "\n\n\n\nYou need to copy \"easybashgui\" in your path ( e.g.: \"cp easybashgui_X.X.X /usr/local/bin/\" )...\n:(\n\n\n\n" 1>&2 && usage
#
source easybashgui
num_param=${#}
eval ${funct} $(for (( index=1 ; index <= ${num_param} ; index++ ))
			do
			echo -n "\"${1}\" "
			shift
		done ) 
clean_temp
# bye! ;-)
