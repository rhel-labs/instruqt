---
slug: 02-setting-account-password
id: yzeg42fdlbuy
type: challenge
title: Setting the Account Password
teaser: Working with the passwd and chage commands
notes:
- type: text
  contents: |-
    User accounts are particularly useful because they require authentication. Individuals must input a matching username and password to access a user account.

    The `passwd` command is used to configure passwords. Calling it with no arguments will default to changing the password for the account you are logged in as. With root permission, `passwd` can be called with a name of another user account to set their password.
tabs:
- title: Shell
  type: terminal
  hostname: rhel
difficulty: basic
timelimit: 600
---
Like with `useradd`, you must have root access to use this command. Set the password for the guest account you created in the previous step using the following command:

```
echo rhel | passwd --stdin guest
```

This command will set the password in one line by using the `--stdin` option. This is useful when setting passwords inside a script or any other case when you want to avoid interactively setting the password. If you instead call `passwd guest`, you get a chance to type the password interactively to set it.

Here you use a four-character password for simplicity, but it is best practice to select a more secure password. In fact, non-root users would be unable to use the password __rhel__ for their account because it is too short and does not contain a number or uppercase letter. Root users can bypass these guidelines if they wish.

Validate the password by using the list (`-l`) option for the `chage` command:

```chage -l guest
```

<pre class=file>
Last password change                                    : Oct 21, 2021
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : never
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7
</pre>

This outputs useful information about when the password was last changed, when the password expires, and how long the user will have to change their password before it becomes inactive.

>_NOTE:_ You can view this same information with the `passwd` command using various options, but `chage -l` provides it in a much more human-readable and concise format.

You can use the `passwd` command for many more actions, such as setting an expiration date or locking users from logging in with their password. Check out the Enable Sysadmin article [Managing Linux users with the passwd command](https://www.redhat.com/sysadmin/managing-users-passwd) for more information on these actions.