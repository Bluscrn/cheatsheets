Markdown
===

# Headers

```markdown
# h1
## h2
### h3
#### h4
##### h5
###### h6
```

# h1
## h2
### h3
#### h4
##### h5
###### h6

Headers with seperators

```markdown
Header 1
===
```

Header 1
===


```markdown
Header 2
---
```

Header 2
---

# Emphasis

```markdown
*italic*
_italic_
```
*italic*
_italic_

```markdown
**bold**
__bold__
```
**bold**
__bold__

```markdown
__*bold&italic*__
```
__*bold&italic*__

# Lists

```markdown
* Item 1
* Item 2
```

* Item 1
* Item 2

```markdown
- Item 1
- Item 2
```

- Item 1
- Item 2

```markdown
- [ ] Checkbox off
- [x] Checkbox on
```

- [ ] Checkbox off
- [x] Checkbox on

```markdown
1. Item 1
2. Item 2
```

1. Item 1
2. Item 2


# Links

Typical link
```markdown
[google](http://google.com)
```
[google](http://google.com)

google set as a variable
```markdown
[link][google]
[google]: http://google.com
```
[link](http://google.com)

HTML tags work also
```markdown
<http://google.com>
```
<http://google.com>

Location within this document
```markdown
[link text](#heading-text)
```
[Links](#Links)

# Images

Plain picture
```markdown
![Image alt text 1](/path/to/img.jpg)
```
![Image alt text 1](resources/markdown.png)

Title appears when mouse hovers
```markdown
![Image alt text 2](/path/to/img.jpg "title")
```
![Image alt text 2](resources/markdown.png "markdown.png")

img defined as a variable set to a local path
```markdown
[img]: /path/to/img.jpg
![Image alt text 3][img]
```
[img]: resources/markdown.png
![Image alt text 3][img]

img2 set as a variable to a remote path
```markdown
[img2]: http://foo.com/img.jpg
![img2]
```

[img2]: https://e7.pngegg.com/pngimages/918/742/png-clipart-logo-brand-markdown-others-blue-logo-thumbnail.png
![img2]


# Code

```markdown
`code`
```

`code`

```
    4 space indent
    makes a code block
```
    4 space indent
    makes a code block


~~~markdown
```
code fences
```
~~~

```
code fences
```


~~~markdown
```bash
codeFences $(withLanguage)
echo
```
~~~

```bash
codeFences $(withLanguage)
echo 
```


# Blockquotes

```markdown
> This is
> a blockquote
>
> > Nested
> > Blockquote
```

> This is
> a blockquote
>
> > Nested
> > Blockquote


# Horizontal lines

```markdown
----
```

------

```markdown
*****
```

*****

# Tables

```markdown
| Column 1 Heading | Column 2 Heading |
| ---------------- | ---------------- |
| Some content     | Other content    |
```

| Column 1 Heading | Column 2 Heading |
| ---------------- | ---------------- |
| Some content     | Other content    |

```markdown
Column 1 Heading | Column 2 Heading
--- | ---
Some content | Other content
```

Column 1 Heading | Column 2 Heading
--- | ---
Some content | Other content
