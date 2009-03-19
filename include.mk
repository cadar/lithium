compile: 
	erl -make

clean:
	rm -rf ./ebin/*.beam


check-syntax:
	erlc -o ebin $(CHK_SOURCES)
	@screen -p server -X stuff $''make:all().'             


