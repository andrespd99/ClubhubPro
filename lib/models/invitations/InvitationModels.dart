class GuestModel {
  var name;
  var cid;
  var docId;

  GuestModel(this.docId, this.name, this.cid);
}
class FriendModel {
  var docId;
  var name;
  var cid;
  bool isSelected = false;

  FriendModel(this.docId, this.name, this.cid);
}