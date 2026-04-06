# inkwell

- inkwell is the solution aiming to reduce devs stress of having to rewrite codes in creating blogs site 

**i will try to make this readme as short as possible**

## installation
 ```bash
 $ curl -sSL "https://gitlab.com/dart.co/inkwell/-/raw/main/install.sh" | bash
```
this will install and run the install script 
after sucessfull installation you will get the pure binary file 
the run with 
```bash
$ ./inkwell
```
you will get your admin token on first run and will alos be available to view at admin.token it should be used when sending request for admin actions to be included in x-api-key

---
## Endpoints 

1. GET /posts
 - lists all blogs 

 **how it works**
  - Reads all .md files frok posts/ folder
  - returns filename as slug
  - returns file stats (created date, size)

 **response**
 ```json
 [
   {
       "slug": "hello-word",
       "created": "2026-2815....",
       "size": "1240"
   }
]
```
2. GET /posts/:slug

 - gets a single posts

  **how it works**

   lets assume slug is hello-word.md
   - looks for posts/hello-word.md
   - if exit -> reads file content
   - retuns raw markdown

   **response**
   ```json
   [ 
       {
           "slug": "hello-word",
           "content": "markdownhere...",
           "version": "0.1.0"

       }
   ]
   ```
3. GET /search?/q=query
- searches for posts

**how it works**
- loops through all .md files 
- searches in filename and content
- returns matches with excerpts

**response**

```json
[
    {
        "slug": "dart-post",
        "title": "DART-POST",
        "created": "2026.....",
        "excerpt": "this is about dart..
    }
]
```

---
## admin Endpoints
( to be used with X-API-KEY)
 
4. POST /admin/posts
- creates new posts

headers

```text
X-API-KEY: ink_......
Content-Type: application/json
```
> note : all request should follow this format unless stated otherwise

Body
```json
{
    "slug": "my-new-post",
    "content": "markdownhere"
}
```
- will return 409 if slug exits
5. PUT /admin/posts/:slug
- updates an existing post overrides

8. DELETE /admin/posts/:slug
- deletes a post

--- 

**my aim is to keep this as short as possible**

## Auth system
 - generates random token
 - saves to admin.token
 - prints the token 
 - only works on first run 



