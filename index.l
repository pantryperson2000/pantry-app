<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#1f5d3a">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="Kickoff Club">
<link rel="manifest" href="manifest.webmanifest">
<link rel="apple-touch-icon" href="icon-180.png">
<title>Kickoff Club</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,500;12..96,800&family=Figtree:wght@400;500;700&display=swap" rel="stylesheet">
<style>
:root{--turf:#1f5d3a;--turf2:#276b44;--chalk:#f6f7f2;--paper:#ffffff;--ink:#14231b;--mute:#5d6f64;--coin:#e9b62f;--red:#d8432f;--line:#dfe4da;--r:18px;
--display:'Bricolage Grotesque','Trebuchet MS',system-ui,sans-serif;--body:'Figtree',system-ui,-apple-system,'Segoe UI',sans-serif}
@media(prefers-color-scheme:dark){:root:not([data-theme=light]){--chalk:#0f1a14;--paper:#17261d;--ink:#eef2ea;--mute:#9db0a3;--line:#27392e;--turf:#17492c;--turf2:#1d5434}}
*{box-sizing:border-box}
html{scroll-padding-top:env(safe-area-inset-top,0px)}
body{margin:0;background:var(--chalk);color:var(--ink);font:16px/1.5 var(--body);padding-bottom:calc(88px + env(safe-area-inset-bottom,0px))}
button,input,select{font:inherit;color:inherit}
:focus-visible{outline:3px solid var(--coin);outline-offset:2px}
header{background:repeating-linear-gradient(90deg,var(--turf) 0 56px,var(--turf2) 56px 112px);color:#fff;padding:calc(18px + env(safe-area-inset-top,0px)) 20px 64px}
.top{max-width:760px;margin:0 auto;display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap}
.brand{font-size:28px;color:#fff}
.who{display:flex;align-items:center;gap:8px;font-size:14px}
.who select{background:rgba(255,255,255,.14);border:1px solid rgba(255,255,255,.35);border-radius:999px;padding:6px 12px;color:#fff}
.who option{color:#14231b}
.purse{max-width:760px;margin:26px auto 0}
.purse small{opacity:.85;font-size:14px}
.purse .amt{font:800 clamp(44px,12vw,72px)/1 var(--display);letter-spacing:-.03em;display:flex;align-items:center;gap:10px}
.coin{width:.55em;height:.55em;border-radius:50%;background:var(--coin);box-shadow:inset 0 0 0 .07em #b98a10;display:inline-block}
main{max-width:760px;margin:-40px auto 0;padding:0 16px}
.card{background:var(--paper);border:1px solid var(--line);border-radius:var(--r);margin-bottom:16px;overflow:hidden}
.ticket{display:grid;grid-template-columns:1fr auto}
.tmain{padding:16px 18px}
.teams{font:800 22px/1.15 var(--display);letter-spacing:-.01em}
.teams span{color:var(--mute);font-weight:500;font-size:15px;padding:0 6px}
.meta{color:var(--mute);font-size:14px;margin-top:4px}
.tag{display:inline-block;font-size:13px;font-weight:700;padding:2px 10px;border-radius:999px;background:var(--line)}
.tag.live{background:var(--red);color:#fff}.tag.done{background:var(--turf);color:#fff}
.odds{display:grid;grid-template-columns:repeat(2,1fr);border-top:2px dashed var(--line)}
.odd{border:0;border-right:1px solid var(--line);background:transparent;padding:12px 6px;cursor:pointer;text-align:center;transition:background .15s,transform .1s}
.odd:last-child{border-right:0}
.odd:hover:not(:disabled){background:var(--chalk)}
.odd:active:not(:disabled){transform:scale(.97)}
.odd:disabled{opacity:.45;cursor:not-allowed}
.odd b{display:block;font:800 22px/1.1 var(--display)}
.odd i{font-style:normal;font-size:13px;color:var(--mute)}
.odd.mine{background:var(--coin);color:#2b2000}.odd.mine i{color:#2b2000}
.score{font:800 34px/1 var(--display);padding:16px 18px;text-align:center}
nav{position:fixed;left:0;right:0;bottom:0;background:var(--paper);border-top:1px solid var(--line);display:flex;justify-content:center;gap:4px;padding:8px 8px calc(8px + env(safe-area-inset-bottom,0px));z-index:5}
nav button{flex:1;max-width:160px;border:0;background:transparent;border-radius:12px;padding:10px 6px;font-weight:700;color:var(--mute);cursor:pointer}
nav button[aria-current=true]{background:var(--turf);color:#fff}
h2{font:800 24px/1.2 var(--display);margin:22px 4px 12px}
.row{display:flex;justify-content:space-between;align-items:center;gap:10px;padding:14px 18px;border-top:1px solid var(--line)}
.row:first-child{border-top:0}
.rank{font:800 20px var(--display);width:28px;color:var(--mute)}
.row.first .rank{color:var(--coin)}
.won{color:var(--turf);font-weight:700}.lost{color:var(--red);font-weight:700}
.empty{padding:26px 18px;color:var(--mute);text-align:center}
.btn{border:0;background:var(--turf);color:#fff;border-radius:12px;padding:12px 18px;font-weight:700;cursor:pointer}
.btn.alt{background:var(--line);color:var(--ink)}
.form{padding:16px 18px;display:grid;gap:12px}
.form label{display:grid;gap:4px;font-size:14px;color:var(--mute)}
.form input,.form select{background:var(--chalk);border:1px solid var(--line);border-radius:10px;padding:10px 12px;color:var(--ink)}
.g2{display:grid;grid-template-columns:repeat(2,1fr);gap:8px}
.g3{display:grid;grid-template-columns:repeat(3,1fr);gap:8px}
dialog{border:0;border-radius:22px;padding:0;width:min(440px,92vw);background:var(--paper);color:var(--ink)}
dialog::backdrop{background:rgba(10,20,14,.6)}
.slip{padding:22px;display:grid;gap:14px}
.chips{display:flex;gap:8px;flex-wrap:wrap}
.chips button{border:1px solid var(--line);background:var(--chalk);border-radius:999px;padding:6px 14px;cursor:pointer}
.ret{font:800 28px var(--display)}
.toast{position:fixed;left:50%;bottom:calc(96px + env(safe-area-inset-bottom,0px));transform:translateX(-50%);background:var(--ink);color:var(--chalk);padding:10px 18px;border-radius:999px;font-weight:700;z-index:9}
.err{color:var(--red);font-size:14px;min-height:20px}
#welcome{position:fixed;inset:0;z-index:20;background:repeating-linear-gradient(90deg,var(--turf) 0 56px,var(--turf2) 56px 112px);color:#fff;display:flex;flex-direction:column;justify-content:center;padding:24px;padding-top:calc(24px + env(safe-area-inset-top,0px));padding-bottom:calc(24px + env(safe-area-inset-bottom,0px));overflow:auto}
#welcome[hidden]{display:none}
#welcome .in{max-width:520px;width:100%;margin:0 auto}
#welcome h1{font:800 clamp(38px,10vw,60px)/1 var(--display);letter-spacing:-.03em;margin:0 0 8px}
#welcome p{margin:0 0 22px;opacity:.9}
.pick{display:flex;align-items:center;gap:14px;width:100%;background:var(--chalk);color:var(--ink);border:0;border-radius:var(--r);padding:14px 16px;margin-bottom:10px;cursor:pointer;text-align:left;transition:transform .12s}
.pick:hover{transform:translateX(6px)}
.pick .av{width:46px;height:46px;border-radius:50%;background:var(--coin);color:#2b2000;display:grid;place-items:center;font:800 22px var(--display)}
.pick b{font:800 22px var(--display);display:block;line-height:1.1}.pick small{color:var(--mute)}

:root{--spring:cubic-bezier(.34,1.56,.64,1)}
header{border-radius:0 0 30px 30px}
.swbtn{background:rgba(255,255,255,.16);border:1px solid rgba(255,255,255,.4);color:#fff;border-radius:999px;padding:8px 16px;font-weight:700;cursor:pointer;backdrop-filter:blur(10px);-webkit-backdrop-filter:blur(10px);transition:transform .3s var(--spring),background .2s}
.swbtn:hover{background:rgba(255,255,255,.26)}.swbtn:active{transform:scale(.93)}
.card{box-shadow:0 1px 2px rgba(0,0,0,.04),0 10px 28px rgba(20,35,27,.07);transition:transform .3s var(--spring),box-shadow .3s}
.card:hover{transform:translateY(-2px);box-shadow:0 2px 4px rgba(0,0,0,.05),0 16px 36px rgba(20,35,27,.12)}
.odd,.btn,.pick,nav button,.chips button,.pad button{transition:transform .3s var(--spring),background .2s,box-shadow .2s,color .2s}
.odd:active:not(:disabled),.btn:active,.pick:active,nav button:active,.chips button:active,.pad button:active{transform:scale(.93)}
.btn:hover{box-shadow:0 6px 16px rgba(31,93,58,.35)}
nav{background:color-mix(in srgb,var(--paper) 74%,transparent);-webkit-backdrop-filter:blur(20px) saturate(1.7);backdrop-filter:blur(20px) saturate(1.7)}
nav button[aria-current=true]{box-shadow:0 4px 14px rgba(31,93,58,.4)}
.odd.mine{animation:pop .5s var(--spring)}
@keyframes pop{0%{transform:scale(.88)}100%{transform:scale(1)}}
#view.swap{animation:swap .38s cubic-bezier(.2,.8,.2,1)}
@keyframes swap{from{opacity:0;transform:translateY(6px) scale(.992)}to{opacity:1;transform:none}}
dialog[open]{animation:sheet .45s var(--spring);box-shadow:0 30px 80px rgba(0,0,0,.35)}
dialog[open]::backdrop{animation:fade .3s;-webkit-backdrop-filter:blur(6px);backdrop-filter:blur(6px)}
@keyframes sheet{from{opacity:0;transform:translateY(40px) scale(.94)}to{opacity:1;transform:none}}
@keyframes fade{from{opacity:0}to{opacity:1}}
.toast:not([hidden]){animation:toastin .5s var(--spring)}
@keyframes toastin{from{opacity:0;transform:translateX(-50%) translateY(24px) scale(.9)}to{opacity:1;transform:translateX(-50%)}}
.amt.up{animation:up .8s var(--spring)}.amt.down{animation:down .6s}
@keyframes up{0%{transform:scale(1)}35%{transform:scale(1.1);text-shadow:0 0 28px var(--coin)}100%{transform:scale(1)}}
@keyframes down{0%,100%{transform:translateX(0)}25%{transform:translateX(-4px)}60%{transform:translateX(4px)}}
.spark{position:fixed;width:10px;height:10px;margin:-5px;border-radius:50%;background:var(--coin);box-shadow:inset 0 0 0 2px #b98a10;z-index:30;pointer-events:none;animation:fly .75s cubic-bezier(.2,.8,.3,1) forwards}
@keyframes fly{to{transform:translate(var(--dx),var(--dy)) scale(.3);opacity:0}}
.pick{animation:rise .6s var(--spring) backwards;animation-delay:calc(var(--i)*80ms)}
@keyframes rise{from{opacity:0;transform:translateY(26px) scale(.95)}}
.pick:hover{box-shadow:0 10px 26px rgba(0,0,0,.25)}
.pinwrap{text-align:center}.pinwrap .av.big{width:84px;height:84px;font-size:38px;margin:0 auto 12px;border-radius:50%;background:var(--coin);color:#2b2000;display:grid;place-items:center;font-family:var(--display);font-weight:800;animation:pop .5s var(--spring)}
.dots{display:flex;justify-content:center;gap:16px;margin:10px 0 28px}
.dots i{width:16px;height:16px;border-radius:50%;border:2px solid #fff;transition:background .15s,transform .3s var(--spring)}
.dots i.on{background:#fff;transform:scale(1.2)}
.dots.shake{animation:down .45s}
.pad{display:grid;grid-template-columns:repeat(3,76px);gap:14px;justify-content:center}
.pad button{height:76px;border-radius:50%;border:0;background:rgba(255,255,255,.18);color:#fff;font:700 28px var(--display);cursor:pointer;-webkit-backdrop-filter:blur(10px);backdrop-filter:blur(10px)}
.pad button:hover{background:rgba(255,255,255,.3)}
.pad .ghost{background:transparent;font:700 16px var(--body)}

.card.open{cursor:pointer}.more{color:var(--turf);font-weight:700;font-size:13px;margin-left:6px}
@media(prefers-color-scheme:dark){.more{color:var(--coin)}}
.p16{padding:16px 18px}.back{margin:0 0 14px}
.logo{display:inline-grid;place-items:center;width:46px;height:46px;border-radius:50%;color:#fff;font:800 15px var(--display);flex:none;object-fit:contain}
.logo.big{width:84px;height:84px;font-size:26px;box-shadow:0 10px 24px rgba(0,0,0,.2);animation:pop .6s var(--spring)}
.hero{padding-top:22px}.hv{display:flex;justify-content:center;align-items:center;gap:20px;margin-bottom:14px}.vs{color:var(--mute);font-weight:700}
.pctrow{display:flex;justify-content:space-between;align-items:flex-end;padding:18px 18px 8px}
.pctrow b{font:800 40px/1 var(--display);letter-spacing:-.02em}.pctrow small{color:var(--mute);text-align:center;padding:0 8px}
.probbar{display:flex;height:16px;margin:0 18px;border-radius:99px;overflow:hidden;background:var(--line);gap:3px}
.pf{animation:grow 1s cubic-bezier(.2,.8,.2,1) backwards}@keyframes grow{from{width:0}}
.chart{width:100%;height:auto;display:block;margin-bottom:6px}
.ln{stroke-dasharray:1;stroke-dashoffset:0;animation:draw 1.1s ease-out backwards}@keyframes draw{from{stroke-dashoffset:1}}
.tn{font:800 20px var(--display)}
.form5{display:flex;gap:6px;margin:12px 0}
.form5 i{width:28px;height:28px;border-radius:50%;display:grid;place-items:center;font:700 13px var(--body);font-style:normal;color:#fff}
.form5 .w{background:var(--turf)}.form5 .l{background:var(--red)}
.logo{position:relative}.logo img{position:absolute;inset:0;width:100%;height:100%;object-fit:contain}
.tl{display:flex;gap:10px;margin-bottom:10px}.tl .logo{width:42px;height:42px;font-size:13px}
.logo.big{width:96px;height:96px}

html{-webkit-text-size-adjust:100%}
body{-webkit-tap-highlight-color:transparent;overscroll-behavior-y:none;touch-action:manipulation;padding-bottom:calc(120px + env(safe-area-inset-bottom,0px))}
button,.card.open{-webkit-user-select:none;user-select:none}
nav{left:12px;right:12px;bottom:calc(10px + env(safe-area-inset-bottom,0px));max-width:440px;margin:0 auto;display:block;padding:6px;border:1px solid color-mix(in srgb,var(--ink) 10%,transparent);border-radius:32px;background:color-mix(in srgb,var(--paper) 68%,transparent);-webkit-backdrop-filter:blur(26px) saturate(1.8);backdrop-filter:blur(26px) saturate(1.8);box-shadow:0 12px 40px rgba(10,25,16,.22),0 2px 6px rgba(10,25,16,.1)}
nav .tabs{position:relative;display:grid;grid-template-columns:repeat(4,1fr)}
nav .ind{position:absolute;top:0;bottom:0;left:0;width:25%;border-radius:26px;background:color-mix(in srgb,var(--turf) 16%,transparent);transition:transform .5s var(--spring);pointer-events:none}
nav button{position:relative;max-width:none;flex:none;display:flex;flex-direction:column;align-items:center;gap:2px;padding:9px 4px 7px;border-radius:26px;background:transparent;color:var(--mute);font:600 11px/1.1 var(--body);box-shadow:none}
nav button svg{transition:transform .4s var(--spring)}
nav button[aria-current=true]{background:transparent;color:var(--turf);box-shadow:none}
nav button[aria-current=true] svg{transform:translateY(-1px) scale(1.12)}
nav button:active svg{transform:scale(.82)}
@media(prefers-color-scheme:dark){nav button[aria-current=true]{color:var(--coin)}nav .ind{background:color-mix(in srgb,var(--coin) 18%,transparent)}}
.toast{bottom:calc(100px + env(safe-area-inset-bottom,0px))}
main{min-height:calc(100vh - 140px);min-height:calc(100dvh - 140px)}
@media(prefers-reduced-motion:reduce){*,*::before,*::after{transition:none!important;animation:none!important}}
</style>

<style>
.hint{margin:-6px 4px 14px;color:var(--mute,#6b7a70);font-size:14px}
.odds{display:grid;grid-template-columns:1fr 1fr;gap:10px;padding:0 14px 14px}
.odd{position:relative;display:flex;flex-direction:column;align-items:flex-start;gap:2px;text-align:left;padding:14px 14px 12px;border-radius:18px;border:2px solid color-mix(in srgb,var(--tc,#2f7d4f) 55%,transparent);background:linear-gradient(160deg,color-mix(in srgb,var(--tc,#2f7d4f) 22%,transparent),color-mix(in srgb,var(--tc,#2f7d4f) 6%,transparent));color:inherit;font:inherit;cursor:pointer;transition:transform .18s cubic-bezier(.3,1.6,.5,1),box-shadow .18s;overflow:hidden}
.odd:active{transform:scale(.95)}
.odd:hover:not([disabled]){transform:translateY(-2px);box-shadow:0 8px 22px color-mix(in srgb,var(--tc,#2f7d4f) 35%,transparent)}
.odd i{font-style:normal;font-weight:800;font-size:15px;letter-spacing:.2px}
.odd b{font-family:var(--display,inherit);font-size:24px;line-height:1.1;color:var(--coin,#e8b52e);text-shadow:0 1px 0 rgba(0,0,0,.18)}
.odd small{font-size:12px;opacity:.75}
.odd em{font-style:normal;font-size:12px;margin-top:6px;padding:3px 8px;border-radius:99px;background:rgba(127,127,127,.18)}
.odd.mine{box-shadow:0 0 0 3px var(--coin,#e8b52e)}
.odd[disabled]{opacity:.55;cursor:default}
.card.open{transition:transform .2s cubic-bezier(.3,1.4,.5,1),box-shadow .2s}.card.open:active{transform:scale(.985)}
.hero{background:linear-gradient(180deg,color-mix(in srgb,var(--turf,#1f6b43) 18%,transparent),transparent 60%)}
.tag.live{animation:pulse 1.6s infinite}@keyframes pulse{50%{opacity:.5}}
.chips{display:flex;gap:8px;flex-wrap:wrap}.chips button{padding:9px 16px;border-radius:99px;border:1.5px solid var(--line);background:transparent;color:inherit;font-weight:700;transition:transform .15s}.chips button:active{transform:scale(.92)}
.ret{font-family:var(--display,inherit);font-size:26px;color:var(--coin,#e8b52e)}
.sec{margin:14px 0 8px;font-weight:800;font-size:13px;text-transform:uppercase;letter-spacing:.8px;opacity:.75}.sec small{text-transform:none;letter-spacing:0;font-weight:500;margin-left:6px}
.injs{display:flex;gap:8px;flex-wrap:wrap}
.inj{display:flex;align-items:center;gap:8px;padding:6px 12px 6px 6px;border-radius:99px;border:1.5px solid var(--line);background:transparent;color:inherit;font:inherit;text-align:left;cursor:pointer;transition:transform .15s}.inj:active{transform:scale(.95)}
.inj img{width:34px;height:34px;border-radius:50%;object-fit:cover;background:rgba(127,127,127,.2)}.inj b{display:block;font-size:14px}.inj small{opacity:.7;font-size:12px}
.nws{display:grid;gap:10px}.nw{display:flex;gap:12px;align-items:center;text-decoration:none;color:inherit;padding:8px;border-radius:14px;background:rgba(127,127,127,.1);transition:transform .15s}.nw:active{transform:scale(.98)}
.nw img{width:84px;height:60px;border-radius:10px;object-fit:cover;flex:none}.nw span{font-size:14px;font-weight:600;line-height:1.3}
#plr{border:0;border-radius:26px;padding:0;width:min(92vw,440px);max-height:86vh;background:var(--chalk);color:var(--ink)}#plr::backdrop{background:rgba(0,0,0,.55);backdrop-filter:blur(6px)}
.plr{padding:22px;position:relative;text-align:center;display:grid;gap:6px;justify-items:center}.plr .x{position:absolute;right:14px;top:10px;border:0;background:rgba(127,127,127,.2);width:34px;height:34px;border-radius:50%;font-size:22px;color:inherit}
.plr .ph img,.plr .ph .logo{width:110px;height:110px;border-radius:50%;object-fit:cover}.plr h2{margin:6px 0 0}.plr .nws{text-align:left;width:100%}.plr .sec{width:100%;text-align:left}
.pill{padding:5px 14px;border-radius:99px;background:var(--coin,#e8b52e);color:#2b2100;font-weight:800;font-size:13px}
</style>

<style id="ui2">
/* ===== Kickoff Club design system (dark-first). Never targets nav / #nav / .tabs ===== */
@media all{:root{--u-bg:var(--chalk);--u-s1:var(--paper);--u-s2:var(--paper);--u-s3:color-mix(in srgb,var(--ink) 7%,var(--paper));--u-line:var(--line);--u-tx:var(--ink);--u-mu:var(--mute);--u-acc:#1c8a4e;--u-gold:var(--coin);--u-win:#1c8a4e;--u-loss:var(--red);--u-live:#e5384f;--u-r:22px;--u-r2:14px;--u-sh:0 8px 24px rgba(20,35,27,.12)}}
@media(prefers-color-scheme:dark){:root:not([data-theme=light]){--u-acc:#3ddc84;--u-win:#3ddc84;--u-sh:0 10px 28px rgba(0,0,0,.45)}}
html{background:var(--u-bg)}body{background:var(--u-bg);color:var(--u-tx)}
header{background:linear-gradient(180deg,rgba(0,0,0,0),rgba(0,0,0,.28)),repeating-linear-gradient(90deg,var(--turf) 0 56px,var(--turf2) 56px 112px);padding-bottom:76px;border-bottom:0}
.brand{font-size:28px;background:linear-gradient(90deg,#fff 30%,var(--u-acc));-webkit-background-clip:text;background-clip:text;color:transparent}
.swbtn{background:rgba(255,255,255,.1);border:1px solid var(--u-line);border-radius:99px;padding:9px 16px;color:#fff;font-weight:700;min-height:40px;backdrop-filter:blur(10px)}
.purse small{color:rgba(255,255,255,.85);font-weight:700;letter-spacing:.08em;text-transform:uppercase;font-size:12px}
.purse .amt{color:var(--u-gold);text-shadow:0 0 34px rgba(255,201,60,.4)}
#sync{display:inline-flex!important;align-items:center;gap:7px;padding:5px 12px;border-radius:99px;background:rgba(255,255,255,.08);font-size:12px!important;letter-spacing:0!important;text-transform:none!important;font-weight:600;opacity:1!important;color:#fff!important;max-width:100%}
#sync::before{content:"";width:8px;height:8px;border-radius:50%;background:var(--u-acc);box-shadow:0 0 10px var(--u-acc);flex:none}
.card{background:linear-gradient(180deg,var(--u-s2),var(--u-s1));border:1px solid var(--u-line);border-radius:var(--u-r);box-shadow:var(--u-sh)}
.card:hover{border-color:rgba(51,240,138,.35)}
h2{font:800 22px/1.2 var(--display);letter-spacing:-.01em;margin:26px 4px 12px}
.sech{display:flex;align-items:baseline;justify-content:space-between}.hint2{color:var(--u-mu);font-size:13px;font-weight:600}
.meta{color:var(--u-mu)}.hint{color:var(--u-mu)}
.btn{background:linear-gradient(135deg,var(--u-acc),#15b862);color:#032212;border:0;border-radius:var(--u-r2);min-height:50px;font-weight:800;letter-spacing:.01em;box-shadow:0 8px 24px rgba(51,240,138,.3)}
.btn.alt{background:var(--u-s3);color:var(--u-tx);box-shadow:none;border:1px solid var(--u-line)}
.btn.cta{width:100%;min-height:58px;font-size:17px}
.lnk{background:none;border:0;color:var(--u-mu);font-weight:700;min-height:44px;cursor:pointer}
/* match card */
.mc{padding:0;transition:transform .2s cubic-bezier(.3,1.4,.5,1)}.mc:active{transform:scale(.988)}
.mc.live{border-color:rgba(255,61,99,.55);box-shadow:0 0 0 1px rgba(255,61,99,.3),var(--u-sh)}
.mh{display:flex;align-items:center;gap:8px;padding:12px 16px 4px;color:var(--u-mu);font-size:13px;font-weight:600}.mh .when{flex:1}
.st{padding:3px 10px;border-radius:99px;background:var(--u-s3);color:var(--u-tx);font:800 12px var(--body);letter-spacing:.06em;font-variant-numeric:tabular-nums}
.st.live{background:var(--u-live);color:#fff;animation:lv 1.4s infinite}.st.done{background:#2a3a30;color:var(--u-mu)}.st.ref{background:var(--u-gold);color:#2b2100}
@keyframes lv{50%{box-shadow:0 0 0 6px rgba(255,61,99,0)}0%{box-shadow:0 0 0 0 rgba(255,61,99,.6)}}
.boost{padding:3px 10px;border-radius:99px;background:linear-gradient(90deg,var(--u-gold),#ff9d2e);color:#2b1a00;font:800 11px var(--body);letter-spacing:.06em;text-transform:uppercase}
.trow{display:flex;align-items:center;gap:12px;padding:10px 16px}.tinfo{flex:1;min-width:0}.tinfo b{display:block;font:800 18px/1.15 var(--display);white-space:nowrap;overflow:hidden;text-overflow:ellipsis}.tinfo small{color:var(--u-mu);font-size:13px}
.trow .logo{width:46px;height:46px}
.fin{padding:8px 16px;text-align:center;font:800 20px var(--display);color:var(--u-gold)}
.mybet{display:flex;justify-content:space-between;gap:10px;padding:11px 16px;background:rgba(51,240,138,.08);border-top:1px solid var(--u-line);font-size:13px;color:var(--u-mu)}.mybet b{color:var(--u-acc)}
.won{color:var(--u-win);font-weight:800;animation:wn 2s ease-out 1}.lost{color:var(--u-loss);font-weight:800}
@keyframes wn{0%{text-shadow:0 0 0 transparent}30%{text-shadow:0 0 18px var(--u-win)}100%{text-shadow:0 0 0 transparent}}
/* odds chips */
.odd.chip{display:flex;flex-direction:row;align-items:center;justify-content:center;gap:6px;min-width:96px;min-height:48px;padding:0 14px;border-radius:var(--u-r2);border:1px solid var(--u-line);background:var(--u-s3);color:var(--u-tx);box-shadow:none;transform:none}
.odd.chip .am{font:800 20px var(--display);color:var(--u-acc);font-variant-numeric:tabular-nums}
.odd.chip:hover:not([disabled]){border-color:var(--u-acc);box-shadow:0 0 0 3px rgba(51,240,138,.18);transform:none}.odd.chip:active:not([disabled]){transform:scale(.94)}
.odd.chip.mine{background:linear-gradient(135deg,var(--u-gold),#ff9d2e);border-color:transparent}.odd.chip.mine .am{color:#2b1a00}
.odd.chip[disabled]{opacity:.5}
.mvu{color:var(--u-win);font-size:10px;text-decoration:none}.mvd{color:var(--u-loss);font-size:10px;text-decoration:none}
.hero .odds{border:0;padding:0 16px 16px;gap:12px}
.odd.chip.big{flex-direction:column;gap:2px;min-height:96px;padding:12px;background:linear-gradient(160deg,color-mix(in srgb,var(--tc) 40%,var(--u-s3)),var(--u-s3));border:1px solid color-mix(in srgb,var(--tc) 60%,transparent)}
.odd.chip.big i{font-style:normal;font-weight:800;font-size:14px}.odd.chip.big .am{font-size:30px}.odd.chip.big small{color:var(--u-mu);font-size:12px}
/* game page */
.hero{background:radial-gradient(100% 80% at 50% -10%,rgba(51,240,138,.2),transparent 60%),linear-gradient(180deg,var(--u-s2),var(--u-s1))}
.pctrow small{color:var(--u-mu)}.probbar{height:10px;border-radius:99px;background:var(--u-s3)}
.card.p16{padding:16px}.sec{color:var(--u-mu)}
.form5 i{border-radius:8px}.inj{background:var(--u-s3);border-color:var(--u-line)}.nw{background:var(--u-s3)}
/* rows (My bets, Table, Admin) */
.row{border-top:1px solid var(--u-line);padding:16px 18px;min-height:60px}.row.first .rank{color:var(--u-gold)}.rank{color:var(--u-mu)}
/* forms */
.form{padding:18px;display:grid;gap:14px}.form label{color:var(--u-mu);font-weight:700;font-size:13px;display:grid;gap:6px}
.form input,.form select,.row input{background:var(--u-s3);border:1px solid var(--u-line);color:var(--u-tx);border-radius:12px;padding:12px;min-height:46px;width:100%}
/* dialogs */
dialog{background:var(--u-s1);color:var(--u-tx);border:1px solid var(--u-line);border-radius:28px;box-shadow:var(--u-sh)}dialog::backdrop{background:rgba(0,0,0,.65);backdrop-filter:blur(8px)}
#plr{background:var(--u-s1);color:var(--u-tx)}
.slip{padding:22px;gap:16px}.sh{display:flex;justify-content:space-between;align-items:center;gap:12px}.sh small{color:var(--u-mu)}.sp{display:flex;align-items:center;gap:10px;margin:6px 0;font:800 22px var(--display)}.sp .logo{width:40px;height:40px}
.sodds{font:800 38px var(--display);color:var(--u-acc)}
.sl{display:grid;gap:6px;color:var(--u-mu);font-weight:700;font-size:13px}.si{display:flex;align-items:center;gap:10px;background:var(--u-s3);border:1px solid var(--u-line);border-radius:var(--u-r2);padding:6px 16px}.si .coin{font-size:34px}
.si input{background:none;border:0;font:800 34px var(--display);color:var(--u-tx);width:100%;min-height:56px;outline:0;padding:0}
.chips button{background:var(--u-s3);border:1px solid var(--u-line);border-radius:99px;padding:10px 18px;min-height:44px;font-weight:800;color:var(--u-tx)}
.sum{background:var(--u-s2);border:1px solid var(--u-line);border-radius:var(--u-r2);padding:6px 16px}.sum div{display:flex;justify-content:space-between;padding:10px 0;color:var(--u-mu)}.sum b{color:var(--u-tx);font:800 18px var(--display);font-variant-numeric:tabular-nums}.sum b.g{color:var(--u-win)}
.sum .tot{border-top:1px dashed var(--u-line);color:var(--u-tx);font-weight:800}.sum .tot b{font-size:26px;color:var(--u-gold)}
.err{color:var(--u-loss);font-weight:700;min-height:1px}
/* picker + PIN */
#welcome{background:radial-gradient(120% 70% at 50% -10%,rgba(51,240,138,.3),transparent 60%),var(--u-bg);color:var(--u-tx)}
.pick{background:linear-gradient(180deg,var(--u-s2),var(--u-s1));border:1px solid var(--u-line);color:var(--u-tx);border-radius:var(--u-r);min-height:68px}.pick:hover{border-color:var(--u-acc)}
.pick .av{background:linear-gradient(135deg,var(--u-acc),#15b862);color:#032212}
.pad button{background:var(--u-s2);border:1px solid var(--u-line);color:var(--u-tx);min-height:60px;border-radius:50%;font:800 24px var(--display)}.dots i{border-color:var(--u-acc)}.dots i.on{background:var(--u-acc)}
/* toast, empty, skeleton */
.toast{background:var(--u-s3);color:var(--u-tx);border:1px solid var(--u-line);box-shadow:var(--u-sh)}
.es{display:grid;justify-items:center;gap:4px;text-align:center;padding:38px 22px}.es .ei{font-size:44px;filter:drop-shadow(0 6px 14px rgba(51,240,138,.35))}.es b{font:800 20px var(--display)}.es p{margin:0;color:var(--u-mu);max-width:30ch}
.sk{display:inline-block;height:14px;width:90px;margin:3px 6px 3px 0;border-radius:8px;background:linear-gradient(90deg,var(--u-s3) 25%,color-mix(in srgb,var(--u-tx) 12%,transparent) 50%,var(--u-s3) 75%);background-size:200% 100%;animation:sk 1.3s infinite linear;vertical-align:middle}
.sk.big{display:block;width:100%;height:56px;border-radius:14px;margin:8px 0}.sk.r{width:46px;height:46px;border-radius:50%}.mc .sk{width:120px}.mc .trow .sk.big{width:96px;height:48px;margin:0 0 0 auto}
@keyframes sk{to{background-position:-200% 0}}
@media(max-width:360px){.odd.chip{min-width:80px;padding:0 10px}.tinfo b{font-size:16px}.sodds{font-size:30px}}
@media(prefers-reduced-motion:reduce){.st.live,.won,.sk{animation:none}}
/* green pitch bands + picker, like the original design */
.mh{background:repeating-linear-gradient(90deg,var(--turf) 0 28px,var(--turf2) 28px 56px);color:rgba(255,255,255,.92);padding:10px 16px;border-radius:var(--u-r) var(--u-r) 0 0}
.mh .st{background:rgba(255,255,255,.22);color:#fff}.mh .st.live{background:var(--u-live)}.mh .st.done{background:rgba(0,0,0,.32)}
.trow{padding:12px 16px}
#welcome{background:repeating-linear-gradient(90deg,var(--turf) 0 56px,var(--turf2) 56px 112px);color:#fff}
.pick{background:rgba(255,255,255,.13);border-color:rgba(255,255,255,.28);color:#fff}.pick:hover{border-color:var(--coin)}.pick .av{background:var(--coin);color:#2b2000}
.pad button{background:rgba(255,255,255,.13);border-color:rgba(255,255,255,.28);color:#fff}.dots i{border-color:#fff}.dots i.on{background:var(--coin)}
</style>
</head>
<body>
<header>
  <div class="top">
    <div class="brand">Kickoff Club</div>
    <button class="swbtn" id="sw" type="button"></button>
  </div>
  <div class="purse"><small>Your coins</small><div class="amt"><span class="coin"></span><span id="bal">0</span></div><small id="sync" style="display:block;margin-top:6px;opacity:.85"></small></div>
</header>
<main id="view"></main>
<nav id="nav"></nav>
<div id="welcome" role="dialog" aria-label="Choose player"></div>
<dialog id="slip"></dialog>
<dialog id="plr"></dialog>
<div id="toast" class="toast" hidden></div>

<script src="config.js"></script>
<script>
/* ---------- Store: the only place that reads/writes data. Swap this for Supabase later. ---------- */
const KEY='kickoff-club-v4';
const RULES={start:1000,minStake:10,maxShare:.5,rescueBelow:50,rescueTo:100};
const CFG=window.KICKOFF||{};
const ONLINE=!!(CFG.url&&CFG.key);
let ver=null;
const api=(path,opt={})=>fetch(CFG.url.replace(/\/$/,'')+'/rest/v1/'+path,{...opt,headers:{apikey:CFG.key,'Content-Type':'application/json',...(opt.headers||{})}});
const store={
  load(){try{const s=localStorage.getItem(KEY);if(s)return JSON.parse(s)}catch(e){}return null},
  save(s){try{localStorage.setItem(KEY,JSON.stringify(s))}catch(e){}},
  async pull(){const r=await api('state?id=eq.1&select=data,version');if(!r.ok){let t='';try{t=(await r.text()).slice(0,140)}catch(_){}throw new Error('HTTP '+r.status+' '+t)}const j=await r.json();if(!j[0])throw new Error('ROW row 1 is missing in table state');return j[0]},
  async push(s){const {me:_m,...data}=s;const hasV=(ver!==null&&ver!==undefined);const r=await api('state?id=eq.1&version='+(hasV?'eq.'+ver:'is.null'),{method:'PATCH',headers:{Prefer:'return=representation'},body:JSON.stringify({data,version:(hasV?ver:0)+1})});if(!r.ok){let t='';try{t=(await r.text()).slice(0,140)}catch(_){}throw new Error('HTTP '+r.status+' '+t)}const j=await r.json();return j.length?j[0]:null}
};
const H=3600e3;
function seed(){
  const names=['Elior','Gavriel','Yoni','Yehuda'];
  const now=Date.now();
  return{me:1,nextId:100,
    players:names.map((n,i)=>({id:i+1,name:n,balance:RULES.start,pin:['4827','1593','7064','3351'][i]})),
    matches:[
      {id:1,home:'Chiefs',away:'Bills',kickoff:now+26*H,odds:{H:1.85,A:2.00},hist:[48,49,51,50,52],status:'open'},
      {id:2,home:'Eagles',away:'Cowboys',kickoff:now+50*H,odds:{H:1.60,A:2.40},hist:[57,58,59,59,60],status:'open'},
      {id:3,home:'49ers',away:'Packers',kickoff:now-2*H,odds:{H:1.95,A:1.95},hist:[51,50,49,50,50],status:'open'}
    ],bets:[]};
}
let S=store.load()||seed();
const $=s=>document.querySelector(s);
const esc=t=>String(t).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const me=()=>S.players.find(p=>p.id===S.me);
const fmt=n=>Math.round(n).toLocaleString();
const when=t=>new Date(t).toLocaleString([],{weekday:'short',day:'numeric',month:'short',hour:'2-digit',minute:'2-digit'});
const locked=m=>m.status!=='open'||Date.now()>=m.kickoff;
const pn=(m,k)=>k==='H'?m.home:m.away;
function commit(){store.save(S);render();sync()}
function toast(t){const e=$('#toast');e.textContent=t;e.hidden=false;clearTimeout(toast.t);toast.t=setTimeout(()=>e.hidden=true,2400)}

/* ---------- Game rules ---------- */
function maxStake(p){return Math.floor(p.balance*RULES.maxShare)}
function placeBet(mid,pick,stake){
  const m=S.matches.find(x=>x.id===mid),p=me();
  if(!m||locked(m))return'Betting is closed for this match.';
  if(S.bets.some(b=>b.pid===p.id&&b.mid===mid))return'You already have a bet on this match.';
  if(!Number.isInteger(stake)||stake<RULES.minStake)return'The minimum bet is '+RULES.minStake+' coins.';
  if(stake>maxStake(p))return'The maximum bet is '+fmt(maxStake(p))+' coins (half your balance).';
  p.balance-=stake;
  S.bets.push({id:S.nextId++,pid:p.id,mid,pick,stake,odds:m.odds[pick],result:'pending',payout:0});
  commit();return null;
}
function settle(mid,h,a,q){
  const m=S.matches.find(x=>x.id===mid);
  m.status='done';m.score={h,a};
  const res=h>a?'H':h<a?'A':'T';
  S.bets.filter(b=>b.mid===mid&&b.result==='pending').forEach(b=>{
    const p=S.players.find(x=>x.id===b.pid);
    if(res==='T'){b.result='refund';b.payout=b.stake;p.balance+=b.stake}
    else if(b.pick===res){b.result='won';b.payout=Math.round(b.stake*b.odds);p.balance+=b.payout}else b.result='lost';
  });
  S.players.forEach(p=>{if(p.balance<RULES.rescueBelow)p.balance=RULES.rescueTo});
  if(!q)commit();
}
function cancelMatch(mid,q){
  const m=S.matches.find(x=>x.id===mid);m.status='cancelled';
  S.bets.filter(b=>b.mid===mid&&b.result==='pending').forEach(b=>{
    S.players.find(x=>x.id===b.pid).balance+=b.stake;b.result='refund';b.payout=b.stake});
  if(!q)commit();
}

/* ---------- Views ---------- */
let tab='matches';
const TABS=[['matches','Matches'],['bets','My bets'],['table','Table'],['admin','Admin']];
const ICONS={"matches": "<svg viewBox=\"0 0 24 24\" width=\"26\" height=\"26\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.8\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><rect x=\"3\" y=\"6\" width=\"18\" height=\"12\" rx=\"3\"/><path d=\"M9 6v12\" stroke-dasharray=\"2 2.4\"/><path d=\"M13 10.5h4M13 13.5h3\"/></svg>", "bets": "<svg viewBox=\"0 0 24 24\" width=\"26\" height=\"26\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.8\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><circle cx=\"12\" cy=\"12\" r=\"8.5\"/><circle cx=\"12\" cy=\"12\" r=\"4.5\"/><path d=\"M12 9.5v5M10.4 11h2.6a1 1 0 010 2h-2\"/></svg>", "table": "<svg viewBox=\"0 0 24 24\" width=\"26\" height=\"26\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.8\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M4 20V12h4v8M10 20V5h4v15M16 20v-6h4v6\"/><path d=\"M3 20h18\"/></svg>", "admin": "<svg viewBox=\"0 0 24 24\" width=\"26\" height=\"26\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.8\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M4 7h9M17 7h3M4 17h3M11 17h9\"/><circle cx=\"15\" cy=\"7\" r=\"2.2\"/><circle cx=\"9\" cy=\"17\" r=\"2.2\"/></svg>"};
function updateNav(){
  const n=$('#nav');
  if(!n.dataset.built){n.dataset.built=1;n.innerHTML='<div class="tabs"><i class="ind"></i>'+TABS.map(([k,l])=>`<button data-tab="${k}">${ICONS[k]}<span>${l}</span></button>`).join('')+'</div>'}
  n.querySelectorAll('button').forEach(b=>b.setAttribute('aria-current',String(b.dataset.tab===tab)));
  n.querySelector('.ind').style.transform=`translateX(${TABS.findIndex(t=>t[0]===tab)*100}%)`;
}
let picked=false,pinFor=null,pinBuf='',swap=false,shownBal=null,shownId=null;
function showWelcome(){
  pinFor=null;pinBuf='';const w=$('#welcome');w.hidden=false;
  w.innerHTML='<div class="in"><h1>Kickoff Club</h1><p>Who are you playing as?</p>'+S.players.map((p,i)=>`<button class="pick" style="--i:${i}" data-pick="${p.id}"><span class="av">${esc(p.name[0])}</span><span><b>${esc(p.name)}</b><small>${fmt(p.balance)} coins</small></span></button>`).join('')+(picked?`<button class="btn alt" data-close style="margin-top:6px">Stay as ${esc(me().name)}</button>`:'')+'</div>';
}
function askPin(id){
  pinFor=S.players.find(p=>p.id===id);pinBuf='';
  $('#welcome').innerHTML=`<div class="in pinwrap"><div class="av big">${esc(pinFor.name[0])}</div><h1 style="font-size:34px">${esc(pinFor.name)}</h1><p>Enter your 4-digit code</p><div class="dots" id="dots">${'<i></i>'.repeat(4)}</div><div class="pad">${[1,2,3,4,5,6,7,8,9].map(n=>`<button data-k="${n}">${n}</button>`).join('')}<button class="ghost" data-k="back">Back</button><button data-k="0">0</button><button class="ghost" data-k="del">Delete</button></div></div>`;
}
function pinKey(k){
  if(!pinFor)return;
  if(k==='back'){showWelcome();return}
  if(k==='del')pinBuf=pinBuf.slice(0,-1);else if(pinBuf.length<4)pinBuf+=k;
  document.querySelectorAll('#dots i').forEach((d,i)=>d.classList.toggle('on',i<pinBuf.length));
  if(pinBuf.length===4){
    if(pinBuf===pinFor.pin){S.me=pinFor.id;picked=true;pinFor=null;$('#welcome').hidden=true;commit()}
    else{const d=$('#dots');d.classList.add('shake');if(navigator.vibrate)navigator.vibrate(120);setTimeout(()=>{pinBuf='';d.classList.remove('shake');d.querySelectorAll('i').forEach(i=>i.classList.remove('on'))},450)}
  }
}
function setBal(p){
  const el=$('#bal');
  if(shownId!==p.id||shownBal===null){shownId=p.id;shownBal=p.balance;el.textContent=fmt(p.balance);return}
  if(p.balance===shownBal)return;
  const from=shownBal,to=p.balance,t0=performance.now(),box=el.parentElement;shownBal=to;
  box.classList.remove('up','down');void box.offsetWidth;box.classList.add(to>from?'up':'down');
  (function step(t){const k=Math.min(1,(t-t0)/700),e=1-Math.pow(1-k,3);el.textContent=fmt(from+(to-from)*e);if(k<1)requestAnimationFrame(step)})(t0);
}
function burst(){
  const c=document.querySelector('.coin');if(!c)return;const r=c.getBoundingClientRect();
  for(let i=0;i<14;i++){const s=document.createElement('span');s.className='spark';const a=Math.random()*6.28,d=40+Math.random()*70;
    s.style.cssText=`left:${r.left+r.width/2}px;top:${r.top+r.height/2}px;--dx:${Math.cos(a)*d}px;--dy:${Math.sin(a)*d}px`;
    document.body.appendChild(s);setTimeout(()=>s.remove(),800)}
}

/* ---------- Game page. Team info below is SAMPLE data; replace with a live feed later. ---------- */
let detail=null;
const TEAMS={
  Chiefs:{c:'#e31837',ab:'KC',rec:'9-1',form:'WWLWW',inj:['Tight end (questionable)'],news:['Offense looks sharp after the bye week']},
  Bills:{c:'#00338d',ab:'BUF',rec:'8-2',form:'WWWLW',inj:['None listed'],news:['Defense has not allowed 20 points in three games']},
  Eagles:{c:'#004c54',ab:'PHI',rec:'9-1',form:'WWWWL',inj:['Cornerback (out)'],news:['Run game leads the league']},
  Cowboys:{c:'#003594',ab:'DAL',rec:'5-5',form:'LWLWL',inj:['Linebacker (doubtful)'],news:['Quarterback practiced in full this week']},
  '49ers':{c:'#aa0000',ab:'SF',rec:'7-3',form:'WLWWW',inj:['Receiver (questionable)'],news:['Back from a short week']},
  Packers:{c:'#203731',ab:'GB',rec:'7-3',form:'WWLWL',inj:['None listed'],news:['Young receivers stepping up']}
};
const tm=n=>TEAMS[n]||{c:'#4a5d52',ab:n.slice(0,3).toUpperCase(),rec:'-',form:'',inj:[],news:[]};
const ESPN={Cardinals:'ari',Falcons:'atl',Ravens:'bal',Bills:'buf',Panthers:'car',Bears:'chi',Bengals:'cin',Browns:'cle',Cowboys:'dal',Broncos:'den',Lions:'det',Packers:'gb',Texans:'hou',Colts:'ind',Jaguars:'jax',Chiefs:'kc',Raiders:'lv',Chargers:'lac',Rams:'lar',Dolphins:'mia',Vikings:'min',Patriots:'ne',Saints:'no',Giants:'nyg',Jets:'nyj',Eagles:'phi',Steelers:'pit','49ers':'sf',Seahawks:'sea',Buccaneers:'tb',Titans:'ten',Commanders:'wsh'};
const badge=(n,big)=>{const t=tm(n),k=ESPN[n],u=k?`https://a.espncdn.com/i/teamlogos/nfl/500/${k}.png`:t.logo;return`<span class="logo ${big?'big':''}" style="background:${t.c}">${u?`<img src="${esc(u)}" alt="${esc(n)} logo" loading="lazy" referrerpolicy="no-referrer" onload="var b=this.parentNode.style;b.background='transparent';b.color='transparent';b.boxShadow='none'" onerror="if(!this.dataset.t&&'${k}'){this.dataset.t=1;this.src='https://a.espncdn.com/i/teamlogos/nfl/500/scoreboard/${k}.png'}else{this.remove()}">`:''}${esc(t.ab)}</span>`};
const probH=m=>{const a=1/m.odds.H,b=1/m.odds.A;return Math.round(a/(a+b)*100)};
function chart(m){
  const h=m.hist;if(!h||h.length<2)return'<div class="meta">The odds history shows here once the odds change.</div>';
  const X=i=>10+i/(h.length-1)*280,Y=v=>95-Math.max(20,Math.min(80,v)-20)*(85/60);
  const pts=h.map((v,i)=>`${X(i).toFixed(1)},${Y(v).toFixed(1)}`).join(' ');
  return`<svg viewBox="0 0 300 100" class="chart" role="img" aria-label="${esc(m.home)} win chance over the week"><line x1="10" x2="290" y1="${Y(50)}" y2="${Y(50)}" stroke="var(--line)" stroke-dasharray="4 4"/><polyline points="${pts}" fill="none" stroke="${tm(m.home).c}" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" pathLength="1" class="ln"/>${h.map((v,i)=>`<circle cx="${X(i)}" cy="${Y(v)}" r="${i===h.length-1?5:3}" fill="${tm(m.home).c}"/>`).join('')}</svg><div class="meta">${esc(m.home)} win chance this week: ${h[0]}% to ${h[h.length-1]}%</div>`;
}
const pctK=(m,k)=>k==='H'?probH(m):100-probH(m);
const amer=d=>d>=2?'+'+Math.round((d-1)*100):'-'+Math.round(100/(d-1));
let liveDone=false;
const rcOf=n=>{const i=INFO[ESPN[n]];return(i&&i!=='load'&&i.record)||(tm(n).rec!=='-'?tm(n).rec:'')};
function mv(m,k){const h=m.hist;if(!h||h.length<2)return'';let d=h[h.length-1]-h[h.length-2];d=k==='H'?d:-d;return d>0?'<u class="mvu">&#9650;</u>':d<0?'<u class="mvd">&#9660;</u>':''}
function oddBtn(m,k,mine,lock,big){const o=m.odds[k],n=pn(m,k);return`<button class="odd chip ${big?'big':''} ${mine&&mine.pick===k?'mine':''}" data-bet="${m.id}:${k}" ${lock?'disabled':''} aria-label="Bet on ${esc(n)}, ${pctK(m,k)}% chance">${big?`<i>${esc(n)}</i>`:''}<span class="am">${pctK(m,k)}%</span>${mv(m,k)}${big?`<small>Tap to bet</small>`:''}</button>`}
const cd=m=>{const ms=m.kickoff-Date.now();if(m.status==='done')return'FINAL';if(m.status==='cancelled')return'REFUNDED';if(ms<=0)return'LIVE';const s=Math.floor(ms/1e3),d=Math.floor(s/86400),h=Math.floor(s%86400/3600),mi=Math.floor(s%3600/60);return d?d+'d '+h+'h':h?h+'h '+mi+'m':mi+'m '+(s%60)+'s'};
const empty=(ic,t,s)=>`<div class="es"><div class="ei">${ic}</div><b>${t}</b><p>${s}</p></div>`;
const skel=()=>'<div class="card mc"><div class="mh"><i class="sk"></i></div><div class="trow"><i class="sk r"></i><i class="sk big"></i></div><div class="trow"><i class="sk r"></i><i class="sk big"></i></div></div>';
function haptic(){try{if(navigator.vibrate){navigator.vibrate(18);return}}catch(e){}try{const l=document.createElement('label');l.style.cssText='position:fixed;left:-99px;opacity:0';l.innerHTML='<input type="checkbox" switch>';document.body.appendChild(l);l.click();setTimeout(()=>l.remove(),80)}catch(e){}}
setInterval(()=>document.querySelectorAll('[data-cd]').forEach(e=>{const m=S.matches.find(x=>x.id==e.dataset.cd);if(m)e.textContent=cd(m)}),1000);
const INFO={},PL={};
async function loadInfo(m){for(const n of [m.home,m.away]){const ab=ESPN[n];if(!ab||INFO[ab]!==undefined)continue;INFO[ab]='load';
  try{const r=await fetch('/api/nfl?team='+ab);if(!r.ok)throw 0;const j=await r.json();(j.injuries||[]).forEach(x=>PL[x.id]=Object.assign(x,{team:n}));INFO[ab]=j}catch(e){INFO[ab]=false}
  if(detail===m.id)render()}}
function openPlayer(id){const p=PL[id];if(!p)return;const d=$('#plr');
  d.innerHTML=`<div class="plr"><button class="x" id="plx" aria-label="Close">&times;</button><div class="ph">${p.img?`<img src="${esc(p.img)}" alt="" referrerpolicy="no-referrer" onerror="this.remove()">`:badge(p.team)}</div><h2>${esc(p.name)}</h2><div class="meta">${esc(p.pos||'')} &middot; ${esc(p.team)}</div><div class="pill">${esc(p.status||'Listed')}</div><div class="sec">Latest on ${esc(p.name.split(' ').pop())}</div><div class="nws" id="pn"><i class="sk big"></i><i class="sk big"></i></div></div>`;
  d.showModal();$('#plx').onclick=()=>d.close();d.onclick=e=>{if(e.target===d)d.close()};
  fetch('/api/nfl?player='+id).then(r=>r.json()).then(j=>{$('#pn').innerHTML=(j.news&&j.news.length)?j.news.map(a=>`<a class="nw" href="${esc(a.url||'#')}" target="_blank" rel="noopener">${a.img?`<img src="${esc(a.img)}" alt="" loading="lazy" referrerpolicy="no-referrer" onerror="this.remove()">`:''}<span>${esc(a.title||'')}</span></a>`).join(''):'<span class="meta">No fresh stories right now.</span>'}).catch(()=>{$('#pn').innerHTML='<span class="meta">News is not available right now.</span>'})}
document.addEventListener('click',e=>{const b=e.target.closest('[data-player]');if(b)openPlayer(b.dataset.player)});
function vDetail(){
  const m=S.matches.find(x=>x.id===detail);if(!m){detail=null;return vMatches()}
  loadInfo(m);
  const pH=probH(m),pA=100-pH,mine=S.bets.find(b=>b.pid===S.me&&b.mid===m.id),lock=locked(m)||!!mine;
  const side=n=>{const t=tm(n),ab=ESPN[n],i=INFO[ab],ok=i&&i!=='load';
    const rec=(ok&&i.record)||t.rec,form=ok&&typeof i.last5==='string'?i.last5:(ok?'':t.form);
    const inj=ok?(i.injuries.length?i.injuries.map(x=>`<button class="inj" data-player="${esc(x.id)}">${x.img?`<img src="${esc(x.img)}" alt="" referrerpolicy="no-referrer" onerror="this.remove()">`:''}<span><b>${esc(x.name)}</b><small>${esc(x.pos||'')} &middot; ${esc(x.status||'')}</small></span></button>`).join(''):'<span class="meta">No injuries listed</span>'):`<span class="meta">${i==='load'?'<i class="sk"></i><i class="sk"></i><i class="sk"></i>':(esc(t.inj.join(', '))||'None listed')}</span>`;
    const nl=ok?(i.news.length?i.news:(i.general||[])):[];
    const news=nl.length?nl.slice(0,3).map(a=>`<a class="nw" href="${esc(a.url||'#')}" target="_blank" rel="noopener">${a.img?`<img src="${esc(a.img)}" alt="" loading="lazy" referrerpolicy="no-referrer" onerror="this.remove()">`:''}<span>${esc(a.title||'')}</span></a>`).join(''):`<span class="meta">${i==='load'?'<i class="sk big"></i><i class="sk big"></i>':(t.news.map(esc).join('. ')||'Nothing yet')}</span>`;
    return`<div class="card p16"><div style="display:flex;gap:12px;align-items:center">${badge(n)}<div><b class="tn">${esc(n)}</b><div class="meta">Record ${esc(rec)}</div></div></div><div class="form5">${[...form].map(c=>`<i class="${c==='W'?'w':'l'}">${c}</i>`).join('')||'<span class="meta">Last 5 games: nothing yet</span>'}</div><div class="sec">Injuries <small>tap a name</small></div><div class="injs">${inj}</div><div class="sec">News</div><div class="nws">${news}</div></div>`};
  const all=S.bets.filter(b=>b.mid===m.id);
  const friends=locked(m)?(all.length?all.map(b=>`<div class="row"><b>${esc(S.players.find(p=>p.id===b.pid).name)}</b><span>${fmt(b.stake)} on ${esc(pn(m,b.pick))}</span></div>`).join(''):'<div class="empty">Nobody bet on this game.</div>'):'<div class="empty">Everyone\'s bets show here once the game kicks off.</div>';
  return`<button class="btn alt back" data-back>Back to matches</button>
  <article class="card hero"><div class="hv">${badge(m.home,1)}<span class="vs">vs</span>${badge(m.away,1)}</div><div class="teams" style="text-align:center">${esc(m.home)}<span>vs</span>${esc(m.away)}</div><div class="meta" style="text-align:center">${when(m.kickoff)}</div>
  <div class="pctrow"><b style="color:${tm(m.home).c}">${pH}%</b><small>Win chance</small><b style="color:${tm(m.away).c}">${pA}%</b></div>
  <div class="probbar"><div class="pf" style="width:${pH}%;background:${tm(m.home).c}"></div><div class="pf" style="width:${pA}%;background:${tm(m.away).c}"></div></div>
  <div class="odds" style="margin-top:18px">${['H','A'].map(k=>oddBtn(m,k,mine,lock,1)).join('')}</div>${mine?`<div class="meta" style="padding:10px 18px">Your bet &middot; Stake ${fmt(mine.stake)} on ${esc(pn(m,mine.pick))} &middot; Payout if it wins ${fmt(mine.stake*mine.odds)}</div>`:''}</article>
  <h2>How the odds moved</h2><div class="card p16">${chart(m)}</div>
  <h2>The teams</h2>${side(m.home)}${side(m.away)}
  <h2>Friends' bets</h2><div class="card">${friends}</div>`;
}
function render(){
  $('#sw').textContent='Playing as '+me().name;
  setBal(me());
  updateNav();
  const v=$('#view');v.innerHTML=(detail?vDetail:{matches:vMatches,bets:vBets,table:vTable,admin:vAdmin}[tab])();
  if(swap){swap=false;v.classList.remove('swap');void v.offsetWidth;v.classList.add('swap')}
}
function vMatches(){
  const ms=[...S.matches].sort((a,b)=>a.kickoff-b.kickoff),nx=ms.find(m=>!locked(m));
  const head='<div class="sech"><h2>Matches</h2><span class="hint2">Tap a percent to bet</span></div>';
  if(!ms.length)return head+(!liveDone&&ONLINE?skel()+skel()+skel():'<div class="card">'+empty('&#127944;','No games yet','Games load on their own. Check back in a minute.')+'</div>');
  return head+'<p class="hint">The percent is each team chance to win. Tap one to bet.</p>'+ms.map(m=>{
    const mine=S.bets.find(b=>b.pid===S.me&&b.mid===m.id),lock=locked(m)||!!mine,c=cd(m);
    const cls=c==='LIVE'?'live':m.status==='done'?'done':m.status==='cancelled'?'ref':'';
    const row=k=>{const n=pn(m,k),r=rcOf(n);return`<div class="trow">${badge(n)}<div class="tinfo"><b>${esc(n)}</b><small>${esc(r||(k==='H'?'Home':'Away'))}</small></div>${oddBtn(m,k,mine,lock)}</div>`};
    const res=mine?(mine.result==='won'?`<span class="won">WON +${fmt(mine.payout-mine.stake)}</span>`:mine.result==='lost'?'<span class="lost">LOST</span>':mine.result==='refund'?'REFUNDED':`Pays ${fmt(mine.stake*mine.odds)}`):'';
    return`<article class="card mc ${cls}" data-open="${m.id}" tabindex="0"><div class="mh"><span class="when">${when(m.kickoff)}</span>${m===nx?'<span class="boost">&#9889; Featured</span>':''}<span class="st ${cls}" data-cd="${m.id}">${c}</span></div>${row('H')}${row('A')}${m.score?`<div class="fin">${esc(m.home)} ${m.score.h} &ndash; ${m.score.a} ${esc(m.away)}</div>`:''}${mine?`<div class="mybet"><span>Your bet &middot; ${fmt(mine.stake)} on ${esc(pn(m,mine.pick))}</span><b>${res}</b></div>`:''}</article>`}).join('');
}
function vBets(){
  const bs=S.bets.filter(b=>b.pid===S.me).reverse();
  return'<h2>My bets</h2><div class="card">'+(bs.length?bs.map(b=>{const m=S.matches.find(x=>x.id===b.mid);
    const st=b.result==='won'?`<span class="won">+${fmt(b.payout)}</span>`:b.result==='lost'?`<span class="lost">-${fmt(b.stake)}</span>`:b.result==='refund'?'Refunded':`Pays ${fmt(b.stake*b.odds)}`;
    return`<div class="row"><div><b>${esc(m.home)} vs ${esc(m.away)}</b><div class="meta">Stake ${fmt(b.stake)} on ${pn(m,b.pick)}</div></div><div>${st}</div></div>`}).join(''):empty('&#127903;','No bets yet','Pick a game and tap an odds chip to place your first bet.'))+'</div>';
}
function vTable(){
  const ps=[...S.players].sort((a,b)=>b.balance-a.balance);
  return'<h2>Table</h2><div class="card">'+ps.map((p,i)=>{
    const bs=S.bets.filter(b=>b.pid===p.id&&b.result!=='pending'&&b.result!=='refund'),w=bs.filter(b=>b.result==='won').length;
    const big=Math.max(0,...bs.filter(b=>b.result==='won').map(b=>b.payout-b.stake));
    return`<div class="row ${i===0?'first':''}"><div style="display:flex;gap:12px;align-items:center"><span class="rank">${i+1}</span><div><b>${esc(p.name)}</b><div class="meta">${bs.length?Math.round(w/bs.length*100)+'% wins, ':'No settled bets, '}biggest win ${fmt(big)}</div></div></div><b>${fmt(p.balance)}</b></div>`}).join('')+'</div>';
}
function vAdmin(){
  const open=S.matches.filter(m=>m.status==='open');
  return`<h2>Add a match</h2><form class="card form" id="addm"><div class="g3"><label>Home team<input name="home" required></label><label>Away team<input name="away" required></label><label>Kickoff<input name="ko" type="datetime-local" required></label></div>
  <div class="g2"><label>Home win odds<input name="oh" type="number" step="0.01" min="1.01" value="1.90" required></label><label>Away win odds<input name="oa" type="number" step="0.01" min="1.01" value="1.90" required></label></div>
  <button class="btn" type="submit">Add match</button></form>
  <h2>Enter a result</h2><div class="card">${open.length?open.map(m=>`<form class="row" data-settle="${m.id}"><b>${esc(m.home)} vs ${esc(m.away)}</b><span style="display:flex;gap:6px;align-items:center"><input name="h" type="number" min="0" max="99" required style="width:54px" aria-label="Home goals"> - <input name="a" type="number" min="0" max="99" required style="width:54px" aria-label="Away goals"><button class="btn" type="submit">Settle</button><button class="btn alt" type="button" data-cancel="${m.id}">Refund</button></span></form>`).join(''):'<div class="empty">No open matches to settle.</div>'}</div>
  <h2>Reset</h2><div class="card form"><button class="btn alt" id="reset" type="button">Reset everything</button></div>`;
}

/* ---------- Bet slip ---------- */
function openSlip(mid,pick){
  const m=S.matches.find(x=>x.id===mid),p=me(),mx=maxStake(p),d=$('#slip'),o=m.odds[pick],n=pn(m,pick);
  d.innerHTML=`<form class="slip" method="dialog" id="slipf"><div class="sh"><div><small>${esc(m.home)} vs ${esc(m.away)}</small><div class="sp">${badge(n)}<b>${esc(n)}</b></div><small>Chance to win</small></div><div class="sodds">${pctK(m,pick)}%</div></div>
  <label class="sl">Your stake<div class="si"><span class="coin"></span><input id="stake" type="number" inputmode="numeric" min="${RULES.minStake}" max="${mx}" value="${Math.min(50,mx)}"></div></label>
  <div class="chips">${[10,25,50].filter(v=>v<=mx).map(v=>`<button type="button" data-add="${v}">+${v}</button>`).join('')}<button type="button" data-max="${mx}">Max ${fmt(mx)}</button></div>
  <div class="sum"><div><span>Stake</span><b id="sS"></b></div><div><span>Profit</span><b id="sW" class="g"></b></div><div class="tot"><span>Payout if ${esc(n)} win</span><b id="sT"></b></div></div>
  <div class="err" id="err" role="alert"></div><button class="btn cta" type="submit" id="go"></button><button class="lnk" type="button" id="cl">Cancel</button></form>`;
  const upd=()=>{const st=Math.max(0,+$('#stake').value||0);$('#sS').textContent=fmt(st);$('#sW').textContent='+'+fmt(st*o-st);$('#sT').textContent=fmt(st*o);$('#go').textContent='Place bet \u00b7 '+fmt(st)+' coins'};
  upd();$('#stake').oninput=upd;
  d.querySelectorAll('[data-add]').forEach(b=>b.onclick=()=>{$('#stake').value=Math.min(mx,(+$('#stake').value||0)+(+b.dataset.add));upd();haptic()});
  d.querySelectorAll('[data-max]').forEach(b=>b.onclick=()=>{$('#stake').value=b.dataset.max;upd();haptic()});
  $('#cl').onclick=()=>d.close();
  $('#slipf').onsubmit=e=>{e.preventDefault();const er=placeBet(mid,pick,parseInt($('#stake').value,10));if(er){$('#err').textContent=er;haptic()}else{d.close();toast('Bet placed. Good luck!');burst();haptic()}};
  d.showModal();
}

/* ---------- Events ---------- */
document.addEventListener('click',e=>{
  const pk=e.target.closest('[data-pick]');if(pk){askPin(+pk.dataset.pick);return}
  const kk=e.target.closest('[data-k]');if(kk){pinKey(kk.dataset.k);return}
  if(e.target.closest('[data-close]')){$('#welcome').hidden=true;return}
  const t=e.target.closest('[data-tab]');if(t){tab=t.dataset.tab;detail=null;swap=true;window.scrollTo(0,0);render();return}
  const b=e.target.closest('[data-bet]');if(b){const[a,k]=b.dataset.bet.split(':');openSlip(+a,k);return}
  const op=e.target.closest('[data-open]');if(op){detail=+op.dataset.open;swap=true;window.scrollTo(0,0);render();return}
  if(e.target.closest('[data-back]')){detail=null;swap=true;render();return}
  const c=e.target.closest('[data-cancel]');if(c&&confirm('Refund all bets on this match?')){cancelMatch(+c.dataset.cancel);toast('Match cancelled and stakes refunded')}
  if(e.target.id==='reset'&&confirm('This deletes all players, matches and bets for everyone. Continue?')){const k=S.me;S=seed();S.me=k;commit()}
});
document.addEventListener('keydown',e=>{if(e.key==='Enter'&&e.target.matches&&e.target.matches('[data-open]')){detail=+e.target.dataset.open;swap=true;window.scrollTo(0,0);render()}});
document.addEventListener('submit',e=>{
  const f=e.target;
  if(f.id==='addm'){e.preventDefault();const d=new FormData(f);
    S.matches.push({id:S.nextId++,home:d.get('home').trim(),away:d.get('away').trim(),kickoff:new Date(d.get('ko')).getTime(),odds:{H:+d.get('oh'),A:+d.get('oa')},status:'open'});
    const nm=S.matches[S.matches.length-1];nm.hist=[probH(nm)];
    commit();toast('Match added')}
  if(f.dataset.settle){e.preventDefault();const d=new FormData(f);settle(+f.dataset.settle,+d.get('h'),+d.get('a'));toast('Result saved. Bets paid out.')}
});
$('#sw').onclick=showWelcome;
document.addEventListener('keydown',e=>{if($('#welcome').hidden||!pinFor)return;if(/^\d$/.test(e.key))pinKey(e.key);else if(e.key==='Backspace')pinKey('del')});
/* ---------- Online sync (Supabase). Runs only when config.js has a url and key. ---------- */
let pushing=false,dirty=false;
function why(x){const m=String((x&&x.message)||x||'');
  if(/Failed to fetch|NetworkError|Load failed|TypeError/i.test(m))return 'the address in config.js is wrong or unreachable';
  if(/HTTP 401|HTTP 403|Invalid API key|JWT/i.test(m))return 'the key was rejected or access is blocked ('+m.slice(0,90)+')';
  if(/HTTP 404|does not exist|PGRST205/i.test(m))return 'table "state" was not found - run the SQL in this Supabase project ('+m.slice(0,60)+')';
  if(/^ROW/.test(m))return 'the table exists but row 1 is missing - run the SQL again';
  return m.slice(0,140)}
let liveErr='';
function setSync(m,x){const e=$('#sync');if(e)e.textContent=m==='online'?'Online with your friends'+(liveErr?' - live games: '+liveErr:''):m==='error'?'Cannot reach the server: '+why(x):'This device only'}
function adopt(r){
  const keep=S.me||1;S=r.data;S.me=keep;ver=r.version;store.save(S);render();
  if(!pinFor&&!$('#welcome').hidden)showWelcome();
}
async function sync(){
  if(!ONLINE)return;
  if(pushing){dirty=true;return}
  pushing=true;
  try{
    const res=await store.push(S);
    if(res){ver=res.version;setSync('online')}
    else{adopt(await store.pull());toast('Someone just made a move. Your last action was not saved. Try again.')}
  }catch(e){setSync('error',e)}
  pushing=false;
  if(dirty){dirty=false;sync()}
}
async function poll(){
  if(pushing||document.hidden)return;
  try{const r=await store.pull();setSync('online');if(r.version!==ver&&!$('#slip').open&&!pinFor)adopt(r)}catch(e){setSync('error',e)}
}
/* ---------- Live NFL games (Cloudflare function /api/nfl) ---------- */
const nick=n=>String(n).trim().split(/\s+/).pop();
async function nfl(q){const r=await fetch('/api/nfl'+q);const j=await r.json().catch(()=>({}));if(!r.ok)throw new Error(j.error||('HTTP '+r.status));return j}
let liveBusy=false;
async function liveSync(){
  if(liveBusy||!ONLINE||pushing)return;
  liveBusy=true;
  try{
    const g=await nfl('');
    if(!g.games)throw new Error('no games in answer');
    let changed=false,added=0,done=0,refreshed=0;
    if(g.games.length){
      const keep=S.matches.filter(m=>!(m.id<=3&&!m.gid&&!S.bets.some(b=>b.mid===m.id)));
      if(keep.length!==S.matches.length){S.matches=keep;changed=true}
    }
    for(const x of g.games){
      const ko=x.ts*1000;
      const m=S.matches.find(k=>k.gid===x.id);
      if(!m){
        if(x.status!=='NS'||ko<=Date.now()||ko-Date.now()>7*24*H||added>=4)continue;
        let o=null;try{o=await nfl('?odds='+x.id)}catch(e){}
        if(!o||!o.home||!o.away)continue;
        S.matches.push({id:S.nextId++,gid:x.id,home:nick(x.home),away:nick(x.away),kickoff:ko,odds:{H:o.home,A:o.away},hist:[Math.round(100/o.home/(1/o.home+1/o.away))],oddsAt:Date.now(),status:'open'});
        added++;changed=true;
      }else if(m.status==='open'){
        if((x.status==='FT'||x.status==='AOT')&&typeof x.hs==='number'&&typeof x.as==='number'){settle(m.id,x.hs,x.as,true);done++;changed=true}
        else if(x.status==='CANC'||x.status==='PST'){cancelMatch(m.id,true);done++;changed=true}
        else if(x.status==='NS'&&m.kickoff!==ko&&ko>Date.now()){m.kickoff=ko;changed=true}
        if(m.status==='open'&&x.status==='NS'&&ko>Date.now()&&refreshed<3&&Date.now()-(m.oddsAt||0)>12*H){refreshed++;m.oddsAt=Date.now();changed=true;let o=null;try{o=await nfl('?odds='+x.id)}catch(e){}
          if(o&&o.home&&o.away){const old=probH(m);m.odds={H:o.home,A:o.away};const nw=probH(m);if(nw!==old||!m.hist)m.hist=(m.hist&&m.hist.length?m.hist:[old]).concat(nw).slice(-12)}}
      }
    }
    liveErr='';
    if(changed){commit();if(added)toast(added+' new game'+(added>1?'s':'')+' added');else if(done)toast('Results updated')}
    else setSync('online');
  }catch(e){liveErr=String(e.message||e).slice(0,110);setSync('online')}
  liveDone=true;liveBusy=false;if(!S.matches.length)render();
}

async function boot(){
  render();showWelcome();
  if(!ONLINE){setSync('local');return}
  try{
    const r=await store.pull();
    if(!r.data||!r.data.players){ver=r.version;S=seed();const res=await store.push(S);if(res)ver=res.version;render();showWelcome()}
    else adopt(r);
    setSync('online');
    setInterval(poll,4000);
    liveSync();setInterval(liveSync,300000);
    document.addEventListener('visibilitychange',()=>{if(!document.hidden)poll()});
  }catch(e){setSync('error',e)}
}
boot();
</script>
</body>
</html>
