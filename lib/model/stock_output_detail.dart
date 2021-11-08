class StockOutputDetail {
  String inv;
  String teaminsTall;
  String dATEdetail;
  String empName;
  int pOS;
  int printer;
  int keyboardMouse;
  int scanner;
  int ups;
  int eDCCable;
  int lan1m;
  int stainlesssteelpole;
  int attenna2m;
  int attenna3m;
  int pg11;
  int suargeGuard;
  int paperPrint;
  int fCC;
  int powerFcc;
  int powerCL;
  int lOOP;
  int p2P;
  int kiosPos;
  int kiosFleet;
  int miniPc;
  int fTD;
  int pad;
  int flScanner;
  int hub8;
  int hub16;
  int ordering;
  int lL;
  int lR;
  int eYS;
  int eYK;
  int uion;
  int rubberBlock;
  int socket;
  int puk;
  int clamp;
  int c;
  int compound;
  int fiber;
  int aLLOY;

  StockOutputDetail(
      {this.inv,
      this.teaminsTall,
      this.dATEdetail,
      this.empName,
      this.pOS,
      this.printer,
      this.keyboardMouse,
      this.scanner,
      this.ups,
      this.eDCCable,
      this.lan1m,
      this.stainlesssteelpole,
      this.attenna2m,
      this.attenna3m,
      this.pg11,
      this.suargeGuard,
      this.paperPrint,
      this.fCC,
      this.powerFcc,
      this.powerCL,
      this.lOOP,
      this.p2P,
      this.kiosPos,
      this.kiosFleet,
      this.miniPc,
      this.fTD,
      this.pad,
      this.flScanner,
      this.hub8,
      this.hub16,
      this.ordering,
      this.lL,
      this.lR,
      this.eYS,
      this.eYK,
      this.uion,
      this.rubberBlock,
      this.socket,
      this.puk,
      this.clamp,
      this.c,
      this.compound,
      this.fiber,
      this.aLLOY});

  StockOutputDetail.fromJson(Map<String, dynamic> json) {
    inv = json['Inv'];
    teaminsTall = json['TeaminsTall'];
    dATEdetail = json['DATEdetail'];
    empName = json['emp_name'];
    pOS = json['POS'];
    printer = json['Printer'];
    keyboardMouse = json['KeyboardMouse'];
    scanner = json['Scanner'];
    ups = json['Ups'];
    eDCCable = json['EDCCable'];
    lan1m = json['lan1m'];
    stainlesssteelpole = json['stainlesssteelpole'];
    attenna2m = json['attenna2m'];
    attenna3m = json['attenna3m'];
    pg11 = json['pg11'];
    suargeGuard = json['suargeGuard'];
    paperPrint = json['PaperPrint'];
    fCC = json['FCC'];
    powerFcc = json['PowerFcc'];
    powerCL = json['PowerCL'];
    lOOP = json['LOOP'];
    p2P = json['P2P'];
    kiosPos = json['KiosPos'];
    kiosFleet = json['KiosFleet'];
    miniPc = json['MiniPc'];
    fTD = json['FTD'];
    pad = json['Pad'];
    flScanner = json['FlScanner'];
    hub8 = json['Hub8'];
    hub16 = json['Hub16'];
    ordering = json['Ordering'];
    lL = json['LL'];
    lR = json['LR'];
    eYS = json['EYS'];
    eYK = json['EYK'];
    uion = json['Uion'];
    rubberBlock = json['RubberBlock'];
    socket = json['Socket'];
    puk = json['Puk'];
    clamp = json['Clamp'];
    c = json['C'];
    compound = json['Compound'];
    fiber = json['Fiber'];
    aLLOY = json['ALLOY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Inv'] = this.inv;
    data['TeaminsTall'] = this.teaminsTall;
    data['DATEdetail'] = this.dATEdetail;
    data['emp_name'] = this.empName;
    data['POS'] = this.pOS;
    data['Printer'] = this.printer;
    data['KeyboardMouse'] = this.keyboardMouse;
    data['Scanner'] = this.scanner;
    data['Ups'] = this.ups;
    data['EDCCable'] = this.eDCCable;
    data['lan1m'] = this.lan1m;
    data['stainlesssteelpole'] = this.stainlesssteelpole;
    data['attenna2m'] = this.attenna2m;
    data['attenna3m'] = this.attenna3m;
    data['pg11'] = this.pg11;
    data['suargeGuard'] = this.suargeGuard;
    data['PaperPrint'] = this.paperPrint;
    data['FCC'] = this.fCC;
    data['PowerFcc'] = this.powerFcc;
    data['PowerCL'] = this.powerCL;
    data['LOOP'] = this.lOOP;
    data['P2P'] = this.p2P;
    data['KiosPos'] = this.kiosPos;
    data['KiosFleet'] = this.kiosFleet;
    data['MiniPc'] = this.miniPc;
    data['FTD'] = this.fTD;
    data['Pad'] = this.pad;
    data['FlScanner'] = this.flScanner;
    data['Hub8'] = this.hub8;
    data['Hub16'] = this.hub16;
    data['Ordering'] = this.ordering;
    data['LL'] = this.lL;
    data['LR'] = this.lR;
    data['EYS'] = this.eYS;
    data['EYK'] = this.eYK;
    data['Uion'] = this.uion;
    data['RubberBlock'] = this.rubberBlock;
    data['Socket'] = this.socket;
    data['Puk'] = this.puk;
    data['Clamp'] = this.clamp;
    data['C'] = this.c;
    data['Compound'] = this.compound;
    data['Fiber'] = this.fiber;
    data['ALLOY'] = this.aLLOY;
    return data;
  }
}
