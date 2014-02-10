octo_new
========

A shell script that serves as a crude CMS for Octopress blogs. 

v 3.3 

More information available here: http://sts10.github.io/blog/2014/02/06/octo-new-making-octopress-easier-with-bash/

### Installation (as of v 3.3)

**Recommend you read through the code first** 

To install octo_new v 3.3, 

1. [clone my Git repo](https://github.com/sts10/octo_new). I’d recommend cloning it somewhere in your “code” directory. Inside you’ll find a .sh file and a README. 
2. Open the octo_new.sh file in a text editor like Sublime. On line 19, put in the path to your Octopress directory (user.github.io). Then verify that line 26 is the correct path from your github.io directory to your posts. 
3. Now navigate to your user.github.io directory in your terminal. if you run ```git branch``` you should see two branches: “source” and “master”. Create a new branch called “drafts” but typing ```git branch drafts```. Do NOT checkout the new “drafts” branch, just create. Keep “source” checked out.  
4. Next, you’ll want to put a function in your bash profile so you can call octo_new from anywhere in your terminal. To open your bash profile, run the following in your command line: ```open ~/.bash_profile```. Paste in this function in the top level:
```
function octo_new { bash /Users/$USER/Documents/code/octo_new/octo_new.sh "$1" }
```
Close and reopen your terminal. You should now be able to call ```octo_new``` from anywhere in your terminal to run octo_new.


### Use

From anywhere in the terminal, user can call ```$ octo_new “blog post title”```.

Then user’s default editor launches. The user writes his or her post, saves it, closes the editor. 

User should return to the open terminal window and user will find a menu with three choices: publish, delete, and quit. 

**Publish** adds, commits, and pushes the user’s Git up to GitHub, then deploys your Octopress blog. Here’s the Bash code:

``` bash
  git add .
  git commit -m  "Used octo_new to publish a new post called "$FILENAME"." 
  git push origin source
  rake generate
  rake deploy 
```
and then takes you back to the directory from which you called ```octo_new```.

**Save** moves the file to the users’ “drafts” branch and stores it there. This way publishing the blog through the rake commands does NOT publish the drafts. Users can access their save drafts by entering ```octo_new “drafts”``` from anywhere in the terminal. 

**Delete** removes the file of the post you just created. It also removes it from the source branch of your local Git repo commits it, and pushes to your remote source branch with ```git push origin source```. It then returns the user to the directory from which they originally called ```octo_new```.

**Quit** just returns user to the directory from which they originally called ```octo_new```. It leaves the Git not added, not pushed, and not pushed. It also does not run ```rake generate``` or ```rake deploy```.