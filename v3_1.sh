function octo_new {
  cwd=$(pwd) #save pwd as cwd

  cd /Users/$USER/Documents/code/sts10.github.io 
  if [[ $* == drafts ]]
  then
    git checkout drafts
    ls source/_posts
    echo ''
    echo "Which file from your draft folder would you like to edit? Please enter the file's full name."
    read FILENAME

    cd source/_posts

    if [ ! -f $FILENAME ]  #if this IS a new draft
    then
      echo ''
      echo "Sorry, I don't have that draft. Goodbye."
      cd $cwd
      return 
    fi

    # move $FILENAME from drafts to source, assuming we'll publish it
    git checkout source
    git checkout drafts -- $FILENAME  # get draft from drafts branch, put in source branch

      # commit changes to source branch 
      git add . 
      git commit -m "move your selected draft to source branch"


    # (temporarily) delete $FILENAME from the drafts branch
    git checkout drafts
      rm $FILENAME
      git add --all . 
      git commit -m "move your selected draft to source branch"

    git checkout source

    open $FILENAME

    

  else
    rake new_post["$*"]
    echo "Creating new octopress post called \""$*"\"."  #\""$1"\""

    cd source/_posts
    FILENAME=`ls -t | head -1`
    open $FILENAME
  fi
  
  
 
  clear 
  echo "Welcome to octo_new!"
  echo ""
  echo "I just opened a file called "$FILENAME" for you! Go write an awesome post!"

  echo ''
  echo "Once you've saved the file of your new post, here are your options:"
  echo ''
  echo "p - publish your octopress blog and commit and push your source branch to GitHub"
  echo 's - save this post as a draft. Drafts are accessible by entering octo_new "drafts" on the command line.'
  echo "d - delete the post you just wrote, and remove it from the source branch of your local Git repo"
  echo "q - quit without doing either of the above"
  echo ''

  # echo "Would you like to commit & push your /n git and publish your Octopress blog now? (y/n)"

  read -p "" -n 1 -r  # Maybe give a "(d)elete this post" option 
  echo ''  # (optional) move to a new line

  git checkout source

  if [[ $REPLY =~ ^[Pp]$ ]]    # if [[ $REPLY =~ ^[Yy]$ ]]
  then
      # commit git and publish blog
      
      cd ../../
      
      
      git add .
      git commit -m  "Used octo_new to publish a new post called "$FILENAME"." # $FILENAME ?

      git push origin source
      rake generate
      rake deploy 

      cd $cwd

  elif [[ $REPLY =~ ^[Dd]$ ]]
  then 
      echo ''
      echo "Are you sure you want to delete "$FILENAME"? (y/n) "
      read REPLY2 
      if [[ $REPLY2 =~ ^[Yy]$ ]]
      then
        rm $FILENAME
        git add --all .
        git commit -m "Deleted post "$FILENAME" using octo_new."
        git push origin source
        echo ''
        echo "Deleted "$FILENAME", removed it from Git, and committed and pushed Git"  
        cd $cwd
      else
        echo "OK, we'll just leave it there and cd you into your blog's directory."
        cd ../../
      fi
  elif [[ $REPLY =~ ^[Ss]$ ]]
  then 

    cd ../../

    git add .
    git commit -m "add draft to source branch temporarily"

    git checkout drafts

    if [ ! -f source/_posts/$FILENAME ]  #if this IS a new draft
    then
      echo "Saving new draft!"

      touch source/_posts/$FILENAME
      

    fi 

    git add .
      git commit -m "add blank"


    git checkout source -- source/_posts/$FILENAME  # move the file I'm working on to drafts

    git add .
    git commit -m "add draft "$FILENAME" to drafts branch."


    # clean up the source branch

    git checkout source

    cd source/_posts

    rm $FILENAME
        git add --all .
        git commit -m "Moved post "$FILENAME" to drafts branch and remove from source branch."
        git push origin source

    cd $cwd  

  else
    echo "OK, we'll just leave it there and cd you into your blog's directory."
    cd ../../  # return to main octopress directory
  fi

}