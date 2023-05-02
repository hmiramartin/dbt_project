{% docs gsheet_description %}

| column                   | definition                                                                    |
|--------------------------|-------------------------------------------------------------------------------|
| id                       | Primary key of a table                                                        |
| title                    | Title of a question                                                           |
| body                     | Heading for a body and body itself of every post                              |
| accepted_answer_id       | Id of the answer                                                              |
| answer_count             | Number representation of answers for particular post                          |
| comment_count            | Number representation of comments in post                                     |
| community_owned_date     | Date of transferring ownership from original author of the post to community  |
| creation_date            | Creation date of post                                                         |
| favorite_count           | Number representation of comments in post                                     |
| last_activity_date       | Date of last action, creation/edition of answer                               |
| last_edit_date           | Last edit date of post (answer/question) in Question post                     |
| last_editor_display_name | Name of a last person to edit their post(answer/question) in Question post    |
| last_editor_user_id      | User_id of a last person to edit their post(answer/question) in Question post |
| owner_display_name       | Person that created post                                                      |
| owner_user_id            | Id of a person that created post                                              |
| parent_id                | Is the corresponding question id for the answer, if the post is answer        |
| post_type_id             | Type of post made 1 = Question, 2 = Answer                                    |
| score                    | Number of "This answer is useful" clicked                                     |
| tags                     | Question tag collection that looks like (javascript,python,dbt,cats)          |
| view_count               | Number representation of views of particular post                             |

{% enddocs %}