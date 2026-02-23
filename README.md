# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).

## Deploy in DEV with sqlite test DB

- to deploy by using sqlite use "cds deploy --profile dev"
- Then, to see the data: 
- Clic on SQLTools
- Add new connection
- Give a name and data file as "/home/user/projects/sales/sales.sqlite"
- Run with dev profile with " cds watch --profile dev"

## Github
 - git add .
 - git commit - m "Enter a comment"
 - git push -u origin main (not the best practice in work environment)

## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.
