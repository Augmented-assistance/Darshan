class AppStrings {
  static String get(String language, String key) {
    const english = {
      'chat': 'Chat', 'explore': 'Explore', 'nearby': 'Nearby',
      'heritage': 'Heritage Catalogue', 'nearbyTitle': 'Nearby Heritage',
      'search': 'Search monuments, zones, or architecture...',
      'noResults': 'No monuments found', 'all': 'All', 'nearMe': 'Near Me',
      'recommended': 'Recommended sites', 'valley': 'Kathmandu Valley heritage',
      'ask': 'Ask about a monument', 'hello': 'Hello, visitor',
      'help': 'How can I help today?', 'description': 'Identify a site or ask about history, architecture, and meaning.',
      'conversations': 'Conversations', 'emptyHistory': 'No saved conversations',
      'chooseMedia': 'Add a monument image', 'camera': 'Camera', 'gallery': 'Gallery',
      'listening': 'Listening…', 'voiceError': 'Voice search unavailable',
      'prompt1': 'Who built it?', 'prompt2': 'Why does it matter?', 'prompt3': 'Best time to visit', 'prompt4': 'What should I notice?', 'responding': 'Darshan is responding',
    };
    const nepali = {
      'chat': 'कुराकानी', 'explore': 'अन्वेषण', 'nearby': 'नजिकै', 'heritage': 'सम्पदा सूची', 'nearbyTitle': 'नजिकका सम्पदा',
      'search': 'सम्पदा, क्षेत्र वा वास्तुकला खोज्नुहोस्...', 'noResults': 'सम्पदा भेटिएन', 'all': 'सबै', 'nearMe': 'नजिकै',
      'recommended': 'सिफारिस गरिएका स्थल', 'valley': 'काठमाडौं उपत्यकाका सम्पदा', 'ask': 'सम्पदाबारे सोध्नुहोस्', 'hello': 'नमस्ते, यात्री',
      'help': 'आज म कसरी सहयोग गर्न सक्छु?', 'description': 'स्थल पहिचान गर्नुहोस् वा इतिहास, वास्तुकला र अर्थबारे सोध्नुहोस्।',
      'conversations': 'कुराकानीहरू', 'emptyHistory': 'सुरक्षित कुराकानी छैन', 'chooseMedia': 'सम्पदाको तस्बिर थप्नुहोस्', 'camera': 'क्यामेरा', 'gallery': 'ग्यालरी', 'listening': 'सुन्दैछ…', 'voiceError': 'आवाज खोज उपलब्ध छैन',
      'prompt1': 'कसले बनायो?', 'prompt2': 'यसको महत्व के हो?', 'prompt3': 'भ्रमण गर्ने राम्रो समय', 'prompt4': 'मैले के हेर्नुपर्छ?', 'responding': 'दर्शनले जवाफ दिँदैछ',
    };
    const hindi = {'chat': 'चैट', 'explore': 'खोजें', 'nearby': 'पास में', 'heritage': 'विरासत सूची', 'nearbyTitle': 'पास की विरासत', 'search': 'स्मारक, क्षेत्र या वास्तुकला खोजें...', 'noResults': 'कोई स्मारक नहीं मिला', 'all': 'सभी', 'nearMe': 'पास में', 'recommended': 'अनुशंसित स्थल', 'valley': 'काठमांडू घाटी की विरासत', 'ask': 'किसी स्मारक के बारे में पूछें', 'hello': 'नमस्ते, यात्री', 'help': 'आज मैं आपकी कैसे मदद कर सकता हूँ?', 'description': 'स्थल पहचानें या इतिहास, वास्तुकला और अर्थ के बारे में पूछें।', 'conversations': 'बातचीत', 'emptyHistory': 'कोई सुरक्षित बातचीत नहीं', 'chooseMedia': 'स्मारक की तस्वीर जोड़ें', 'camera': 'कैमरा', 'gallery': 'गैलरी', 'listening': 'सुन रहा है…', 'voiceError': 'वॉइस खोज उपलब्ध नहीं', 'prompt1': 'इसे किसने बनाया?', 'prompt2': 'यह क्यों महत्वपूर्ण है?', 'prompt3': 'घूमने का सबसे अच्छा समय', 'prompt4': 'मुझे क्या देखना चाहिए?', 'responding': 'दर्शन जवाब दे रहा है'};
    const spanish = {'chat': 'Chat', 'explore': 'Explorar', 'nearby': 'Cerca', 'heritage': 'Catálogo patrimonial', 'nearbyTitle': 'Patrimonio cercano', 'search': 'Buscar monumentos, zonas o arquitectura...', 'noResults': 'No se encontraron monumentos', 'all': 'Todo', 'nearMe': 'Cerca de mí', 'recommended': 'Sitios recomendados', 'valley': 'Patrimonio del valle de Katmandú', 'ask': 'Pregunta sobre un monumento', 'hello': 'Hola, visitante', 'help': '¿Cómo puedo ayudarte hoy?', 'description': 'Identifica un sitio o pregunta sobre historia, arquitectura y significado.', 'conversations': 'Conversaciones', 'emptyHistory': 'No hay conversaciones guardadas', 'chooseMedia': 'Añadir imagen del monumento', 'camera': 'Cámara', 'gallery': 'Galería', 'listening': 'Escuchando…', 'voiceError': 'Búsqueda por voz no disponible', 'prompt1': '¿Quién lo construyó?', 'prompt2': '¿Por qué importa?', 'prompt3': 'Mejor momento para visitar', 'prompt4': '¿Qué debo observar?', 'responding': 'Darshan está respondiendo'};
    const french = {'chat': 'Chat', 'explore': 'Explorer', 'nearby': 'À proximité', 'heritage': 'Catalogue du patrimoine', 'nearbyTitle': 'Patrimoine proche', 'search': 'Rechercher monuments, zones ou architecture...', 'noResults': 'Aucun monument trouvé', 'all': 'Tout', 'nearMe': 'Près de moi', 'recommended': 'Sites recommandés', 'valley': 'Patrimoine de la vallée de Katmandou', 'ask': 'Poser une question sur un monument', 'hello': 'Bonjour, visiteur', 'help': 'Comment puis-je vous aider ?', 'description': 'Identifiez un site ou demandez son histoire, son architecture et son sens.', 'conversations': 'Conversations', 'emptyHistory': 'Aucune conversation enregistrée', 'chooseMedia': 'Ajouter une image du monument', 'camera': 'Caméra', 'gallery': 'Galerie', 'listening': 'Écoute…', 'voiceError': 'Recherche vocale indisponible', 'prompt1': 'Qui l’a construit ?', 'prompt2': 'Pourquoi est-ce important ?', 'prompt3': 'Meilleur moment pour visiter', 'prompt4': 'Que dois-je observer ?', 'responding': 'Darshan répond'};
    const chinese = {'chat': '聊天', 'explore': '探索', 'nearby': '附近', 'heritage': '遗产目录', 'nearbyTitle': '附近遗产', 'search': '搜索纪念碑、区域或建筑...', 'noResults': '未找到纪念碑', 'all': '全部', 'nearMe': '附近', 'recommended': '推荐地点', 'valley': '加德满都谷地遗产', 'ask': '询问纪念碑', 'hello': '你好，旅行者', 'help': '今天我能为你做什么？', 'description': '识别地点，或询问历史、建筑和文化意义。', 'conversations': '对话', 'emptyHistory': '没有保存的对话', 'chooseMedia': '添加遗产图片', 'camera': '相机', 'gallery': '图库', 'listening': '正在聆听…', 'voiceError': '语音搜索不可用', 'prompt1': '是谁建造的？', 'prompt2': '为什么重要？', 'prompt3': '最佳参观时间', 'prompt4': '我应该注意什么？', 'responding': 'Darshan 正在回答'};
    final map = switch (language) { 'नेपाली' => nepali, 'हिन्दी' => hindi, 'Español' => spanish, 'Français' => french, '中文' => chinese, _ => english };
    return map[key] ?? english[key] ?? key;
  }
}
