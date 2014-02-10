octo_new
========

A shell script that serves as a crude CMS for Octopress blogs. 

v 3.3 

More information available here: http://sts10.github.io/blog/2014/02/06/octo-new-making-octopress-easier-with-bash/

Installation for v. 3.3+ is a bit tricky. 

1. Go through this code and enter the path to YOUR octopress blog directory where appropriate. 

2. In your octopress blog directory, create a new branch called drafts.

3. Place the following function in to ~/.bash_profile again, with corrected path to where ever you're putting this .sh file :
   ``` function octo_new { bash /Users/$USER/Documents/code/octo_new/octo_new.sh "$1" $(pwd) $3 }```


