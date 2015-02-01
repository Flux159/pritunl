library user_del_comp;

import 'package:pritunl/bases/modal_content/modal_content.dart' as
  modal_content;
import 'package:pritunl/models/user.dart' as usr;
import 'package:pritunl/alert.dart' as alrt;
import 'package:pritunl/logger.dart' as logger;

import 'package:angular/angular.dart' show Component, NgOneWay;
import 'dart:async' as async;

@Component(
  selector: 'user-del',
  templateUrl: 'packages/pritunl/components/user_del/user_del.html',
  cssUrl: 'packages/pritunl/components/user_del/user_del.css'
)
class UserDelComp extends modal_content.ModalContent {
  @NgOneWay('users')
  Set<usr.User> users;

  async.Future submit(async.Future closeHandler()) {
    return async.Future.wait(this.users.map((user) {
      return user.destroy();
    })).then((_) {
      return super.submit(closeHandler);
    }).then((_) {
      new alrt.Alert('Successfully added user.', 'success');
    }).catchError((err) {
      logger.severe('Failed to delete users', err);
      this.setAlert('Failed to delete users, server error occurred.',
        'danger');
    });
  }
}