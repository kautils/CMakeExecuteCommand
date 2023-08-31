### CMakeExecuteGit
* execute git command

### note
* ASSERT  : if error occures then execute message(FATAL_ERROR ... ) with error message from git.   
* VERBOSE : always exevcute message(...) with return value from git 

### example
```cmake
set(__prefix execgit)
set(__dest path_to_dest)
set(__verbose_option VERBOSE)
set(__repo_uri uri_of_repo)
set(__repo_remote origin)
set(__repo_tag tag)

CMakeExecuteGit(${__prefix} COMMAND git init DIR ${__dest} ${__verbose_option} ASSERT) 
CMakeExecuteGit(${__prefix} COMMAND git remote add origin ${__repo_uri} DIR ${__dest} ${__verbose_option})
CMakeExecuteGit(${__prefix} COMMAND git fetch ${__repo_remote} --tags ${__repo_tag} --depth=1 DIR ${__dest} ${__verbose_option} ASSERT)
CMakeExecuteGit(${__prefix} COMMAND git checkout tags/${__repo_tag} DIR ${__dest} ${__verbose_option} ASSERT)
message(${${__prefix}_RESULT_VALUE}) # return value from git
CMakeExecuteGit(${__prefix} CLEAR) # clear internal variable
```
