//
//  InitialDesignVocabularyData.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 16/04/26.
//

import Foundation

public class InitialDesignVocabularyData {
    static let shared = InitialDesignVocabularyData()
    
    private init() {}
    
    var rawDesignVocabularyData = [
        Vocabulary(
            word: "User Interface",
            tag: "Design",
            pronunciation: "yu-zer in-ter-feys",
            meaningEN: "The visual elements users interact with",
            meaningID: "Elemen visual yang digunakan pengguna untuk berinteraksi",
            practiceSentencesEN: [
                "The user interface should be simple and clean.",
                "We redesigned the user interface.",
                "A good user interface improves usability."
            ],
            practiceSentencesID: [
                "User interface harus sederhana dan bersih.",
                "Kami mendesain ulang user interface.",
                "User interface yang baik meningkatkan usability."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "User Experience",
            tag: "Design",
            pronunciation: "yu-zer eks-pee-ri-ens",
            meaningEN: "Overall experience of a user",
            meaningID: "Pengalaman keseluruhan pengguna saat menggunakan produk",
            practiceSentencesEN: [
                "User experience is our priority.",
                "We improved the user experience.",
                "Good UX keeps users engaged."
            ],
            practiceSentencesID: [
                "User experience adalah prioritas kami.",
                "Kami meningkatkan user experience.",
                "UX yang baik membuat pengguna tetap terlibat."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Wireframe",
            tag: "Design",
            pronunciation: "wai-er-frame",
            meaningEN: "Basic layout of a design",
            meaningID: "Kerangka dasar tampilan desain",
            practiceSentencesEN: [
                "We created a wireframe first.",
                "The wireframe shows layout structure.",
                "Wireframes help early planning."
            ],
            practiceSentencesID: [
                "Kami membuat wireframe terlebih dahulu.",
                "Wireframe menunjukkan struktur layout.",
                "Wireframe membantu perencanaan awal."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Prototype",
            tag: "Design",
            pronunciation: "pro-to-type",
            meaningEN: "Interactive model of a product",
            meaningID: "Model interaktif dari sebuah produk",
            practiceSentencesEN: [
                "The prototype simulates real usage.",
                "We tested the prototype.",
                "Prototype helps validate ideas."
            ],
            practiceSentencesID: [
                "Prototype mensimulasikan penggunaan nyata.",
                "Kami menguji prototype.",
                "Prototype membantu validasi ide."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Usability",
            tag: "Design",
            pronunciation: "yu-za-bi-li-tee",
            meaningEN: "Ease of use of a product",
            meaningID: "Kemudahan penggunaan suatu produk",
            practiceSentencesEN: [
                "Usability is very important.",
                "We tested usability.",
                "Good usability improves satisfaction."
            ],
            practiceSentencesID: [
                "Usability sangat penting.",
                "Kami menguji usability.",
                "Usability yang baik meningkatkan kepuasan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Accessibility",
            tag: "Design",
            pronunciation: "ak-ses-i-bi-li-tee",
            meaningEN: "Design usable by all people",
            meaningID: "Desain yang dapat digunakan oleh semua orang",
            practiceSentencesEN: [
                "Accessibility improves inclusivity.",
                "We follow accessibility standards.",
                "Accessibility benefits all users."
            ],
            practiceSentencesID: [
                "Accessibility meningkatkan inklusivitas.",
                "Kami mengikuti standar accessibility.",
                "Accessibility bermanfaat untuk semua pengguna."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Layout",
            tag: "Design",
            pronunciation: "lay-out",
            meaningEN: "Arrangement of elements",
            meaningID: "Susunan elemen dalam desain",
            practiceSentencesEN: [
                "The layout looks clean.",
                "We adjusted the layout.",
                "Layout affects readability."
            ],
            practiceSentencesID: [
                "Layout terlihat bersih.",
                "Kami menyesuaikan layout.",
                "Layout mempengaruhi keterbacaan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Typography",
            tag: "Design",
            pronunciation: "ty-pog-ra-fee",
            meaningEN: "Style of text design",
            meaningID: "Gaya dan pengaturan teks",
            practiceSentencesEN: [
                "Typography affects readability.",
                "We improved typography.",
                "Good typography enhances design."
            ],
            practiceSentencesID: [
                "Typography mempengaruhi keterbacaan.",
                "Kami meningkatkan typography.",
                "Typography yang baik memperindah desain."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Color Palette",
            tag: "Design",
            pronunciation: "kuh-ler pa-let",
            meaningEN: "Set of colors used in design",
            meaningID: "Kumpulan warna yang digunakan dalam desain",
            practiceSentencesEN: [
                "We selected a color palette.",
                "The palette is consistent.",
                "Color palette defines branding."
            ],
            practiceSentencesID: [
                "Kami memilih color palette.",
                "Palet warna konsisten.",
                "Color palette menentukan branding."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Consistency",
            tag: "Design",
            pronunciation: "kun-sis-ten-si",
            meaningEN: "Uniform design across screens",
            meaningID: "Keseragaman desain di seluruh tampilan",
            practiceSentencesEN: [
                "Consistency improves UX.",
                "We maintain consistency.",
                "Consistency builds trust."
            ],
            practiceSentencesID: [
                "Konsistensi meningkatkan UX.",
                "Kami menjaga konsistensi.",
                "Konsistensi membangun kepercayaan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Hierarchy",
            tag: "Design",
            pronunciation: "hai-ark-ee",
            meaningEN: "Arrangement by importance",
            meaningID: "Susunan berdasarkan tingkat kepentingan",
            practiceSentencesEN: [
                "Visual hierarchy guides users.",
                "We improved hierarchy.",
                "Hierarchy highlights key elements."
            ],
            practiceSentencesID: [
                "Hierarki visual membimbing pengguna.",
                "Kami meningkatkan hierarki.",
                "Hierarki menonjolkan elemen penting."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Navigation",
            tag: "Design",
            pronunciation: "na-vi-gay-shun",
            meaningEN: "System to move through app",
            meaningID: "Sistem untuk berpindah dalam aplikasi",
            practiceSentencesEN: [
                "Navigation should be simple.",
                "We redesigned navigation.",
                "Navigation affects usability."
            ],
            practiceSentencesID: [
                "Navigasi harus sederhana.",
                "Kami mendesain ulang navigasi.",
                "Navigasi mempengaruhi usability."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Interaction",
            tag: "Design",
            pronunciation: "in-ter-ak-shun",
            meaningEN: "User actions with interface",
            meaningID: "Interaksi pengguna dengan antarmuka",
            practiceSentencesEN: [
                "Interaction feels smooth.",
                "We improved interaction.",
                "Interaction design is important."
            ],
            practiceSentencesID: [
                "Interaksi terasa halus.",
                "Kami meningkatkan interaksi.",
                "Desain interaksi itu penting."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Microinteraction",
            tag: "Design",
            pronunciation: "mai-kro-in-ter-ak-shun",
            meaningEN: "Small interaction feedback",
            meaningID: "Interaksi kecil yang memberi umpan balik",
            practiceSentencesEN: [
                "Microinteractions improve UX.",
                "We added animations.",
                "They guide users."
            ],
            practiceSentencesID: [
                "Microinteraction meningkatkan UX.",
                "Kami menambahkan animasi.",
                "Hal ini membimbing pengguna."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Responsive Design",
            tag: "Design",
            pronunciation: "re-spon-siv de-zine",
            meaningEN: "Design adapting to screens",
            meaningID: "Desain yang menyesuaikan berbagai ukuran layar",
            practiceSentencesEN: [
                "Responsive design is essential.",
                "It works on all devices.",
                "We tested responsiveness."
            ],
            practiceSentencesID: [
                "Responsive design itu penting.",
                "Bekerja di semua perangkat.",
                "Kami menguji responsivitas."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Grid System",
            tag: "Design",
            pronunciation: "grid sis-tem",
            meaningEN: "Structure for layout alignment",
            meaningID: "Struktur untuk menyusun dan merapikan layout",
            practiceSentencesEN: [
                "Grid keeps alignment clean.",
                "We used grid system.",
                "Grid improves consistency."
            ],
            practiceSentencesID: [
                "Grid membuat layout rapi.",
                "Kami menggunakan grid system.",
                "Grid meningkatkan konsistensi."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Whitespace",
            tag: "Design",
            pronunciation: "white-space",
            meaningEN: "Empty space in design",
            meaningID: "Ruang kosong dalam desain",
            practiceSentencesEN: [
                "Whitespace improves clarity.",
                "We added more space.",
                "Whitespace reduces clutter."
            ],
            practiceSentencesID: [
                "Whitespace meningkatkan kejelasan.",
                "Kami menambah ruang kosong.",
                "Whitespace mengurangi kepadatan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Persona",
            tag: "Design",
            pronunciation: "per-so-na",
            meaningEN: "Fictional user profile",
            meaningID: "Profil pengguna fiktif",
            practiceSentencesEN: [
                "We created personas.",
                "Persona guides design.",
                "Each persona has needs."
            ],
            practiceSentencesID: [
                "Kami membuat persona.",
                "Persona membantu desain.",
                "Setiap persona memiliki kebutuhan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "User Flow",
            tag: "Design",
            pronunciation: "yu-zer flo",
            meaningEN: "Path user takes in app",
            meaningID: "Alur yang dilalui pengguna dalam aplikasi",
            practiceSentencesEN: [
                "User flow was optimized.",
                "We mapped the flow.",
                "Flow should be simple."
            ],
            practiceSentencesID: [
                "User flow dioptimalkan.",
                "Kami memetakan alur.",
                "Alur harus sederhana."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Journey Map",
            tag: "Design",
            pronunciation: "jur-nee map",
            meaningEN: "Visualization of user experience",
            meaningID: "Visualisasi perjalanan pengalaman pengguna",
            practiceSentencesEN: [
                "Journey map shows pain points.",
                "We created a journey map.",
                "It improves UX understanding."
            ],
            practiceSentencesID: [
                "Journey map menunjukkan masalah pengguna.",
                "Kami membuat journey map.",
                "Ini meningkatkan pemahaman UX."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "A/B Testing",
            tag: "Design",
            pronunciation: "a-b tes-ting",
            meaningEN: "Comparing two design versions",
            meaningID: "Membandingkan dua versi desain",
            practiceSentencesEN: [
                "We ran A/B testing.",
                "Version B performed better.",
                "Testing improved conversion."
            ],
            practiceSentencesID: [
                "Kami melakukan A/B testing.",
                "Versi B lebih baik.",
                "Testing meningkatkan konversi."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Design System",
            tag: "Design",
            pronunciation: "de-zine sis-tem",
            meaningEN: "Reusable design standards",
            meaningID: "Standar desain yang dapat digunakan ulang",
            practiceSentencesEN: [
                "We use a design system.",
                "It ensures consistency.",
                "Design system saves time."
            ],
            practiceSentencesID: [
                "Kami menggunakan design system.",
                "Ini menjaga konsistensi.",
                "Design system menghemat waktu."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Component",
            tag: "Design",
            pronunciation: "kom-po-nent",
            meaningEN: "Reusable UI element",
            meaningID: "Elemen UI yang dapat digunakan kembali",
            practiceSentencesEN: [
                "Button is a component.",
                "We reuse components.",
                "Components speed development."
            ],
            practiceSentencesID: [
                "Button adalah komponen.",
                "Kami menggunakan ulang komponen.",
                "Komponen mempercepat pengembangan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Feedback",
            tag: "Design",
            pronunciation: "feed-bak",
            meaningEN: "Response from system or user",
            meaningID: "Respon dari sistem atau pengguna",
            practiceSentencesEN: [
                "Feedback guides design.",
                "We collected feedback.",
                "Feedback improves UX."
            ],
            practiceSentencesID: [
                "Feedback membantu desain.",
                "Kami mengumpulkan feedback.",
                "Feedback meningkatkan UX."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Affordance",
            tag: "Design",
            pronunciation: "a-for-dans",
            meaningEN: "Clues on how to use elements",
            meaningID: "Petunjuk penggunaan elemen dalam desain",
            practiceSentencesEN: [
                "Buttons show affordance.",
                "Users understand actions.",
                "Affordance improves usability."
            ],
            practiceSentencesID: [
                "Tombol menunjukkan affordance.",
                "Pengguna memahami aksi.",
                "Affordance meningkatkan usability."
            ],
            learnHistory: []
        )
    ]
}
