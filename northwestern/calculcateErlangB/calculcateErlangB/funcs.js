const calculateStep = 0.001;

//function RealToText(RealNumber) {
//    var whole, fraction, TextNumber;
//    RealNumber = Math.round(RealNumber * 1000) / 1000;
//    whole = Math.round(RealNumber - 0.5);
//    fraction = Math.round((RealNumber - whole) * 1000);
//    TextNumber = whole + ".";
//    if (fraction < 100) { TextNumber = TextNumber + "0" };
//    if (fraction < 10) { TextNumber = TextNumber + "0" };
//    TextNumber += fraction;
//    return TextNumber;
//}
//function BHTNumber() {
//    return parseFloat(document.erlangb.BHT_Edit.value)
//}
//function LinesNumber() {
//    return parseInt(document.erlangb.Lines_Edit.value, 10)
//}
//function BlockingNumber() {
//    return parseFloat(document.erlangb.Blocking_Edit.value)
//}
function ErlangB(traffic, plines) {
    var PBR, index;
    if (traffic > 0) {
        PBR = (1 + traffic) / traffic;
        for (index = 2; index != plines + 1; index++) {
            PBR = index / traffic * PBR + 1;
            if (PBR > 10000) { return 0; }
        }
        return 1 / PBR;
    }
    else { return 0; }
}
function ErlangBLines(bht, MaximumBlocking) {
    var LinesCount;
    LinesCount = 1;
    while (ErlangB(bht, LinesCount) > MaximumBlocking) { LinesCount++; }
    return LinesCount;
}
function ErlangBBHT(MaximumBlocking, plines) {
    var BHTCount;
    BHTCount = calculateStep;
    while (ErlangB(BHTCount, plines) < MaximumBlocking)
    { BHTCount = BHTCount + calculateStep; }
    return BHTCount - calculateStep;
}
function MakeArray(n) {
    this.length = n;
    for (var i = 1; i <= n; i++) {
        this[i] = 0
    }
    return this
};

module.exports = { ErlangBBHT, ErlangBLines, ErlangB};