class NotificationModel {
  var _id;
  var _productName;

  var _description;

  NotificationModel(this._id, this._productName, this._description);

  get id => _id;
  get productName => _productName;

  get description => _description;
}
