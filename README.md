# Tinylnk

A URL shortener is a web service that takes a long URL and generates a shorter version of it. The purpose of a URL shortener is to create a more compact and manageable URL that is easier to share, especially on platforms with character limitations, such as social media.

Let's take a look at the working of the URL shortener called Tinylnk, which shortens URLs to the format "https://tinylnk.nl/code," where "code" is replaced with a unique identifier for each URL.

1. Input: The user provides a long URL that they want to shorten. For example, let's say the user wants to shorten the URL "https://www.example.com/long-url".

2. Generation of unique code: Tinylnk generates a unique code to replace the "code" portion in the shortened URL. This unique code is usually a combination of alphanumeric characters, and it serves as a reference to the original long URL.

3. Storage: The long URL and its associated unique code are stored in a database. This allows the URL shortener to retrieve the original long URL when someone accesses the shortened URL later.

4. Shortened URL creation: Tinylnk constructs the shortened URL by combining its base domain "https://tinylnk.nl/" with the unique code generated in step 2. In this case, let's assume the unique code is "abc123". The shortened URL becomes "https://tinylnk.nl/abc123".

5. Redirection: When someone clicks on or accesses the shortened URL "https://tinylnk.nl/abc123," the URL shortener receives the request. It looks up the associated long URL in its database using the unique code "abc123".

6. Redirection to the original URL: Once the long URL is retrieved from the database, the URL shortener redirects the user's web browser to the original long URL, in this case, "https://www.example.com/long-url". The redirection happens transparently, usually within milliseconds, so the user is quickly directed to the intended web page.

By utilizing this process, Tinylnk effectively shortens long URLs into more concise versions that are easier to share and remember.

## Integration project

This repository contains the base infrastructure to run Tinylnk. It creates an Azure resource group with Log Analytics, a Storage Account, a Key Vault and a Container Apps Environment.
