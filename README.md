# HINO-CONNECT DRIVER App

HINO-CONNECT DRIVER App is an application to track trucks from driver's reports.

## Setup

- Dart Version: 3.3.4

- Flutter Version: 3.19.6

- Using Get Cli (Recommended) (https://pub.dev/packages/get_cli)

- Using FVM to control flutter version (Recommended) (https://fvm.app/documentation/getting-started)

## Getting Started

This project will use Clean Architecture Design, please read more about this Architecture Design and follow the pattern. 

- https://medium.com/@yamen.abd98/clean-architecture-in-flutter-mvvm-bloc-dio-79b1615530e1

Folder Structure

- Presentation: UI and Controller, contains code about ui logic
- Domain: Entities, Use Case, and Repository Interfaces, contains code about business logic
- Infrastructure: Contains application's config, like Theme, Navigation, etc.
- Data: Repository, DTO and Data Source, contains code about fetching data either from Local or API


DTO:

Model represent data from API


Entity:

Model that will be used by the presentation layer
