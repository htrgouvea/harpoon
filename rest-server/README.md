# RESTfull SERVER of Uranus

A simple and basic Rest API write at Perl.

##### Setup

```bash
	docker build
	docker run
```

##### Requets examples

```bash
	# To view all posts
	curl http://localhost:8080/posts

	# To view just Posts with ID equal to 5
	curl http://localhost:8080/posts/5

	# To delete the post with id equal to 3
	curl -X "DELETE" http://localhost:8080/posts/3

	# To update the body and title of the post with id equal to 4
	curl -X PUT http://localhost:8080/posts/4 -F body="string" -F title="string"

	#
	curl
```