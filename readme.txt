tes 
あいうえお
ab
かきくけこ
uu
time
commit
--------------------
# git time env test; on windows

>> git commit --amend (最終コミットメッセージの修正)
  env設定がなければCommitDateが現在時刻になる
>> git commit --amend --date="Sat May 7 13:11:09 2016 +0900"
>> git log --pretty=fuller
　AuthorDate: Sat May 7 13:11:09 2016 +0900(--date)
  CommitDate: Sat May 7 13:20:42 2016 +0900(現在時刻)

# at 13:23
>> set GIT_AUTHOR_DATE=2016-05-07 13:00:35 +0900
>> set GIT_COMMITTER_DATE=2016-05-07 13:00:35 +0900

>> git commit --amend
  AuthorDate: Sat May 7 13:11:09 2016 +0900(変更なし)
  CommitDate: Sat May 7 13:00:35 2016 +0900(env)
>> git commit --amend --date="%GIT_AUTHO_DATRE%"
  AuthorDate: Sat May 7 13:00:35 2016 +0900(--date)
  CommitDate: Sat May 7 13:00:35 2016 +0900(env)


# cf.
# https://git-scm.com/docs/git-commit-tree.html
# http://tech.nitoyon.com/ja/blog/2013/11/20/cvs2git/
# http://qiita.com/piruty_joy/items/2fbfd26fd8dcbfed592a
# http://qiita.com/watilde/items/1a86d7fcc69dbdbcfd2a
