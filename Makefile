# Members
MEMBER_DOCS= \
	members/member1/index members/member2/index members/member3/index

# Teaching
TEACHING_DOCS= \
	teaching/course1/index teaching/course2/index teaching/course3/index

# Software
SOFTWARE_DOCS= \
	software/tool1/index software/tool2/index  software/tool3/index

# Research
RESEARCH_DOCS= \
	research/topic1/index research/topic2/index research/topic3/index

# All Jemdoc files
DOCS=index teaching members research publications software news contacts $(TEACHING_DOCS) $(MEMBER_DOCS) $(RESEARCH_DOCS) $(SOFTWARE_DOCS)

## HTML Files
HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix html/, $(HDOCS))

.PHONY : all
all : $(PHDOCS)
	rm -f html/*.jemdoc
	cp -f -r ./jemdoc/images ./html
	cp -f -r ./jemdoc/rss ./html
	cp -f -r ./eqs ./html | true
	@echo "Website building is complete !"

html/%.html : jemdoc/%.jemdoc jemdoc/jemdoc.css
	$(eval HTML_FILE_PATH := $@)
	$(eval JEMDOC_FILE_PATH := $<)
	$(eval HTML_DIR := $(shell dirname $(HTML_FILE_PATH)))
	$(eval JEMDOC_DIR := $(shell dirname $(JEMDOC_FILE_PATH)))
	$(eval HTML_FILE_NAME := $(shell basename $(HTML_FILE_PATH)))
	$(eval JEMDOC_FILE_NAME := $(shell basename $(JEMDOC_FILE_PATH)))
	mkdir -p $(HTML_DIR)
	cp $(JEMDOC_DIR)/*.* $(HTML_DIR)
	rm -f $(HTML_DIR)/$(JEMDOC_FILE_NAME)
	./jemdoc.py -c website.conf -o $@ $<

.PHONY : clean
clean :
	rm -f -r html/
	rm -f -r eqs/

.PHONY : install
install :
	curl https://jemdoc.jaboc.net/dist/jemdoc.py > ./jemdoc.py
	chmod +x ./jemdoc.py

.PHONY : pull
pull :
	git pull

.PHONY : push
push :
	git add .
	git commit -m"Some modifications"
	git push
	
.PHONY : publishall
publishall :
	$(eval ftp_site := mywebsite.com)
	$(eval FTP_MIRROR_PATH := html)
	$(eval USERNAME ?= $(shell read -p "FTP Username: " pwd; echo $$pwd))
	$(eval PASSWORD ?= $(shell read -p "FTP Password: " pwd; echo $$pwd))
	$(MAKE) pull
	lftp -e "set ftp:ssl-allow no; set xfer:clobber on; get /rss/news.rss; exit" -u $(USERNAME),$(PASSWORD) $(ftp_site)
	cp news.rss ./news_bkp/$(shell date --iso=seconds).rss	
	mv news.rss ./html/rss/
	$(MAKE) push -i
	$(MAKE) all	
	lftp -e "set ftp:ssl-allow no; mirror -Rne ./$(FTP_MIRROR_PATH) /; exit" -u $(USERNAME),$(PASSWORD) $(ftp_site)
	
	