==Can be interview question.== Versions control systems: centralized (CVS) and Distributed (Git). 

![](Attachments/Pasted%20image%2020240629042017.png)
The image illustrates a comparison between centralized and distributed version control systems, focusing on tools like CVS, SVN, and Git.

1. **Version Control Overview**:
   - Version control helps manage changes to source code over time.
   - The main tools discussed are CVS, SVN, and Git.

2. **Centralized vs. Distributed Version Control**:
   - **Centralized**:
     - Tools: CVS, SVN.
     - Characteristics: A single central repository where all the changes are tracked. Developers need to be connected to the server to commit and retrieve changes.
   - **Distributed**:
     - Tool: Git.
     - Characteristics: Each developer has a local copy of the entire repository, allowing for commits, branching, and merging locally without needing to connect to a central server.

3. **Diagram Explanation**:
   - The top portion shows how CVS and SVN fit into the centralized model, while Git represents the distributed approach.
   - The bottom diagrams illustrate interactions between developers (Dev1, Dev2) and their repositories, showing how the centralized system has a single point of submission, while the distributed system allows direct interaction between developers and local repositories.

This visual emphasizes the fundamental differences between these version control paradigms, particularly highlighting the independence and flexibility offered by distributed systems like Git compared to traditional centralized ones like SVN.

Commands I should know:
`git init`
`git add filename`
`git clone URL`
`git log`
`git commit -m` or `git commit -a`
`git checkout`
`git push`
`git remote`

Later he is explaining how to create repository on github
I already created it before and also tried to do some manipulations with github(pushing and cloning)

At the beginning he explain how to clone and push(generating ssh key).

The difference between FORK and CLONE is that FORK creates a copy of your repository, CLONE only pull the code from remote repository(guthub)

To create a branch you can use:
`git checkout -b "nameofbranch"`

To get commits from another branch these commands used:
`git cherry-pick` , `git merge`, `git rebase`

Git cherry-pick. Just use the commit id of the commit from another branch. Here the commit from branch "division" cherry-picked to "main" branch.
![](Attachments/Pasted%20image%2020240629050308.png)

==`git merge` when merging the another branch to main branch creates a new merge commit. This mechanism makes commit history look like "branching history" variant.==
#### Example Commit History

- **Linear History**
    A---B---C---D---E
- **Branching History**:
   A---B---C---D---E
     \       /
      F---G---H

==`git rebase` makes commit history linear==. It doesn't keep any branching history (for example if we do rebase after merge, it will remove merge commit and makes all commit history looks linear). The new commits will appear as if they were made sequentially after the commits in the base branch.


==ChatGpt==
#### Git Merge
- **Purpose**: Combines changes from two branches, creating a merge commit.
- **History**: Preserves the full history of both branches, showing all commits and the merge.
- **Usage**: Ideal for integrating feature branches and keeping a complete history.
- **Command**: `git checkout main`, `git merge feature`
#### Git Rebase
- **Purpose**: Reapplies commits from one branch on top of another base commit.
- **History**: Rewrites history to create a linear sequence of commits.
- **Usage**: Ideal for cleaning up commit history before merging.
- **Command**: `git checkout feature`, `git rebase main`
#### Summary
- **Merge**: Preserves complete history, can be cluttered.
- **Rebase**: Creates a cleaner, linear history, rewrites commit history.
Choose `merge` to keep a detailed history and `rebase` for a streamlined commit history.
