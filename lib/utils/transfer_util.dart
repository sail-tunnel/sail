class TransferUtil {
  int _transfer = 0;
  int _level = 0;
  List suffix = [
    'B',
    'KB',
    'MB',
    'GB',
    'TB',
    'PB'
  ];

  String toHumanReadable(int transfer) {
    _transfer = transfer;
    handleTransfer();

    return '$_transfer ${suffix[_level]}';
  }

  handleTransfer() {
    if (_transfer > 1024) {
      _transfer = _transfer ~/ 1024;
      ++_level;
      handleTransfer();
    }
  }
}
