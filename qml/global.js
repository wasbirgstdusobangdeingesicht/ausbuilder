var mainBgColor = '#0c1e30'
var myGreen = '#e0f40b'
var selectedPhraseColor = "#1e2629"
var fontFamily = "Times New Roman"

function scaled(x) {
    //console.log("scaleRatio: " + scaleRatio + "; " + x + ">>>" + x*scaleRatio);
    return Math.round(x * scaleRatio);
}

function findInListModel(lm, pred)
{
    for (var i=0; i< lm.count; ++i)
        if (pred(lm.get(i)))
            return i
    return -1
}
