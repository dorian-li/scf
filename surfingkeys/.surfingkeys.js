// setting
// try to be the same as neovim
api.map("<Ctrl-d>", "d");
api.map("<Ctrl-u>", "e");
api.map("H", "E");
api.map("L", "R");
api.map("u", "S");
api.map("<Ctrl-r>", "D");
api.map("<Space>c", "x");
// search in zhihu with search suggestions return
api.addSearchAlias(
  "z",
  "zhihu",
  "https://www.zhihu.com/search?q=",
  "s",
  "https://www.zhihu.com/api/v4/search/suggest?q=",
  (response) => {
    const res = JSON.parse(response.text);
    const suggest = res.suggest;
    return suggest.map((r) => r.query);
  }
);
// search in bilibili with search suggestions return
api.addSearchAlias(
  "v",
  "bilibili",
  "https://search.bilibili.com/all?keyword=",
  "s",
  "https://s.search.bilibili.com/main/suggest?func=suggest&suggest_type=accurate&term=",
  (response) => {
    const res = JSON.parse(response.text);
    const suggest = Object.entries(res);
    return suggest.map((r) => r[1].value);
  }
);
// search in github
api.addSearchAlias("h", "github", "https://github.com/search?utf8=✓&q=", 'o');

// tab switch
settings.tabsThreshold = 0;
settings.tabsMRUOrder = false;
// faster j,k scroll
settings.scrollStepSize = 140;
// shortcut keys to speed up bilibili`s video playback
const get_bilibili_acc_btn_selector=(level)=>{
  const levels={'1.5x':'2','1.25x':'3','1.0x':'4'}
  selector=`#bilibili-player > div > div > div.bpx-player-primary-area > div.bpx-player-video-area > div.bpx-player-control-wrap > div.bpx-player-control-entity > div.bpx-player-control-bottom > div.bpx-player-control-bottom-right > div.bpx-player-ctrl-btn.bpx-player-ctrl-playbackrate > ul > li:nth-child(${levels[level]})`
  return selector
}

api.mapkey("<Space>sa", "Video Speed Up 1.5x", function() {
  const acc_btn_1point5=document.querySelector(get_bilibili_acc_btn_selector('1.5x'))
  acc_btn_1point5.click()
}, {domain: /bilibili\.com/i});

api.mapkey("<Space>sb", "Video Speed Up 1.25x", function() {
  const acc_btn_1point25=document.querySelector(get_bilibili_acc_btn_selector('1.25x'))
  acc_btn_1point25.click()
}, {domain: /bilibili\.com/i});

api.mapkey("<Space>sr", "Video Speed Reset", function() {
  const acc_btn_1=document.querySelector(get_bilibili_acc_btn_selector('1.0x'))
  acc_btn_1.click()
}, {domain: /bilibili\.com/i});
// use Q to lookup english/chinese words with youdao
api.Front.registerInlineQuery({
  url: function (q) {
    return `http://dict.youdao.com/w/eng/${q}/#keyfrom=dict2.index`;
  },
  parseResult: function (res) {
    const parser = new DOMParser();
    const doc = parser.parseFromString(res.text, "text/html");
    const collinsResult = doc.querySelector("#collinsResult");
    const authTransToggle = doc.querySelector("#authTransToggle");
    const examplesToggle = doc.querySelector("#examplesToggle");
    if (collinsResult) {
      collinsResult
        .querySelectorAll("div>span.collinsOrder")
        .forEach(function (span) {
          span.nextElementSibling.prepend(span);
        });
      collinsResult.querySelectorAll("div.examples").forEach(function (div) {
        div.innerHTML = div.innerHTML
          .replace(/<p/gi, "<span")
          .replace(/<\/p>/gi, "</span>");
      });
      const exp = collinsResult.innerHTML;
      return exp;
    } else if (authTransToggle) {
      authTransToggle.querySelector("div.via.ar").remove();
      return authTransToggle.innerHTML;
    } else if (examplesToggle) {
      return examplesToggle.innerHTML;
    }
  },
});
// style
// Zenbonse theme
settings.theme = `
.sk_theme {
  font-family: SauceCodePro Nerd Font, Consolas, Menlo, monospace;
  font-size: 10pt;
  background: #f0edec;
  color: #2c363c;
}
.sk_theme tbody {
  color: #f0edec;
}
.sk_theme input {
  color: #2c363c;
}
.sk_theme .url {
  color: #1d5573;
}
.sk_theme .annotation {
  color: #2c363c;
}
.sk_theme .omnibar_highlight {
  color: #88507d;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
  background: #f0edec;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
  background: #cbd9e3;
}
#sk_status,
#sk_find {
  font-size: 10pt;
}
`;
