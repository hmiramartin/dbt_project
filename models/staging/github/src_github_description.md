{% docs src_github_description %}

| column              | definition                                                            |
|---------------------|-----------------------------------------------------------------------|
| type                | Type of an Event.                                                     |
| public              | Information about whether the event is public or private              |
| payload             | Event payload in JSON format                                          |
| repo - id           | Id of repository associated with event                                |
| repo - name         | Name of repository associated with event                              |
| repo - url          | API url endpoint to repository associated with event                  |
| actor - id          | Id of a person that generated the event                               |
| actor - login       | Login name of a person that generated the event                       |
| actor - gravatar_id | Gravatar id of the organization of the person generated the event     |
| actor - avatar_url  | API url endpoint to img of an person that created the event           |
| actor - url         | API url endpoint to person that created the event                     |
| org - id            | Id of the organization of the associated repository                   |
| org - login         | Login of the organization of the associated repository                |
| org - gravatar_id   | Gravatar id of the organization of the associated repository          |
| org - avatar_url    | API url endpoint to img of an avatar that belongs to the organization |
| org - url           | API url endpoint to organization of the associated repository         |
| created_at          | Event creation time                                                   |
| id                  | Id of the event                                                       |
| other               | Unknown fields in JSON format                                         |

{% enddocs %}