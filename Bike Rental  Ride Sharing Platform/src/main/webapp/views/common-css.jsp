<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>
    /* 🚀 2026 Vibrant Orange Glass Theme */
    * {
        margin: 0; padding: 0; box-sizing: border-box;
        /* 🎯 මුළු වෙබ් අඩවියේම ෆොන්ට් එක මෙතනින් මාරු වෙනවා */
        font-family: 'Inter', sans-serif;
    }

    body {
        background-color: #ffd8c4;
        background-image:
            radial-gradient(circle at 10% 20%, rgba(255, 90, 0, 0.35) 0%, transparent 50%),
            radial-gradient(circle at 90% 40%, rgba(255, 60, 0, 0.25) 0%, transparent 50%),
            radial-gradient(circle at 50% 100%, rgba(255, 120, 50, 0.4) 0%, transparent 60%);
        background-attachment: fixed;
        color: #333;
        min-height: 100vh;
        overflow-x: hidden;
    }

    /* 🧭 Navbar */
    nav {
        position: sticky; top: 0; z-index: 100; display: flex; align-items: center; justify-content: space-between;
        padding: 0 28px; height: 75px; background: rgba(255, 255, 255, 0.5);
        border-bottom: 1px solid rgba(255, 255, 255, 0.8); backdrop-filter: blur(20px);
        box-shadow: 0 4px 30px rgba(255, 106, 0, 0.15);
    }

    /* 🏷️ Logo & Headers වලට විතරක් ලස්සනට Bebas Neue එක තියාගත්තා */
    .logo-name, .hero-h1, .sec-title, .bname, .bprice, h1, h2, h3 {
        font-family: 'Bebas Neue', sans-serif !important;
        letter-spacing: 2px;
    }

    .logo-bolt { width: 38px; height: 38px; background: linear-gradient(135deg, #ff6a00, #ee0979); border-radius: 9px; display: flex; align-items: center; justify-content: center; font-size: 20px; color: #fff; box-shadow: 0 4px 10px rgba(255, 106, 0, 0.3); }
    .logo-name { font-size: 28px; letter-spacing: 3px; background: linear-gradient(90deg, #e65c00, #f9d423); -webkit-background-clip: text; -webkit-text-fill-color: transparent; line-height: 1; }

    /* 🔘 Nav Buttons */
    .np { padding: 8px 16px; border-radius: 8px; font-size: 12px; font-weight: 800; letter-spacing: 1px; text-transform: uppercase; cursor: pointer; border: 1px solid transparent; background: transparent; color: #111; transition: all .2s; display: flex; align-items: center; gap: 8px; text-decoration: none; }
    .np i { font-size: 15px; }
    .np:hover { color: #ff6a00; background: rgba(255, 255, 255, 0.6); border-color: rgba(255, 106, 0, 0.2); box-shadow: 0 2px 10px rgba(255,106,0,0.1); }

    /* 📦 Glass Cards */
    .glass-card {
        background: rgba(255, 255, 255, 0.45); backdrop-filter: blur(16px);
        border: 1px solid rgba(255, 255, 255, 0.7); border-radius: 15px; overflow: hidden;
        box-shadow: 0 8px 32px rgba(255, 106, 0, 0.15); padding: 25px;
    }

    /* Buttons */
    .btn-orange {
        background: linear-gradient(135deg, #ff6a00, #ee0979); border: none; color: #fff;
        padding: 10px 20px; border-radius: 8px; font-weight: 700; text-transform: uppercase; transition: 0.3s;
    }
    .btn-orange:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255, 106, 0, 0.4); color: white;}

    footer { text-align: center; padding: 40px; font-size: 13px; color: #666; letter-spacing: 2px; border-top: 1px solid rgba(255,106,0,0.2); margin-top: 50px;}
</style>