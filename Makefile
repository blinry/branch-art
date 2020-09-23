%:
	ruby $@.rb > $@.txt
	ruby knit.rb $@.txt > $@.sh
	sh $@.sh
