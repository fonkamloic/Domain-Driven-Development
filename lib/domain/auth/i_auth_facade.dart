import 'package:dartz/dartz.dart';
import 'package:ddd/domain/auth/user.dart';
import 'package:ddd/domain/auth/valid_objects.dart';
import 'package:ddd/domain/core/auth_failure.dart';
import 'package:flutter/material.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    @required EmailAddress emailAdrress,
    @required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAdrress,
    @required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<Option<User>> getSignedInUser();
  Future<void> signOut();
}
