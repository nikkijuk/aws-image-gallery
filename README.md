# aws_image_gallery

aws image gallery app

## Getting Started

This project is based on [AWS Amplify Flutter hand-on lab](https://aws.amazon.com/getting-started/hands-on/build-flutter-app-amplify/).

## AWS Amplify Flutter

At the time this repository was created [AWS Amplify Flutter](https://github.com/aws-amplify/amplify-flutter) was at developer preview and supported limited set of services.

- Authentication with [Amazon AWS Cognito](https://aws.amazon.com/cognito/)
- Storage with Amazon [AWS S3](https://aws.amazon.com/s3/)
- Analytics with [Amazon AWS Pinpoint](https://aws.amazon.com/pinpoint/)

It's important to study [current roadmap](https://github.com/aws-amplify/amplify-flutter/issues/5) to understand future directions and ideas behind development.

Important: current focus is at Mobile and IOS & Android parity, not at Desktop or Web

> Q. Will web and Desktop platform be supported?
> Not right away, our goal with this design is to keep the architecture flexible such that more platforms can be supported in the future.

## Learnings

It all worked pretty fine. I thinks aws-amplify-flutter is very promising technology.

Dart code on [lab](https://aws.amazon.com/getting-started/hands-on/build-flutter-app-amplify/) was not always completely tidy, but I added [Very Good Analysis](https://pub.dev/packages/very_good_analysis) to project and styling was easy to fix.

SingUp was implemented in a way that didn't seem to work. I needed to read [authentication docs](https://docs.amplify.aws/lib/auth/signin/q/platform/flutter) and change it.

For most part it was clear what one should do to follow lab, but it wasn't always evident to me.

Navigation could be simplified using [Flutter Bloc](https://pub.dev/packages/flutter_bloc), but here it was good to use basic flutter features.

## Documentation

[Aws Amplify Flutter docs](https://docs.amplify.aws/lib/q/platform/flutter)
