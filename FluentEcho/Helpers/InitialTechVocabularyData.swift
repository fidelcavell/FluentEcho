//
//  InitialVocabularyData.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 15/04/26.
//

import Foundation

public class InitialTechVocabularyData {
    static let shared = InitialTechVocabularyData()
    
    private init() {}
    
    // Note: Number of data = 25 items
    var rawTechVocabularyData = [
        Vocabulary(
            word: "Agile",
            tag: "Technology",
            pronunciation: "a-jail",
            meaningEN: "A flexible and iterative approach to project management",
            meaningID: "Pendekatan fleksibel dan iteratif dalam manajemen proyek",
            practiceSentencesEN: [
                "Our team uses Agile to deliver features in short sprints.",
                "Agile allows quick adaptation to changes.",
                "Daily standups are part of Agile.",
            ],
            practiceSentencesID: [
                "Tim kami menggunakan Agile untuk merilis fitur dalam sprint singkat.",
                "Agile memungkinkan adaptasi cepat terhadap perubahan.",
                "Daily standup adalah bagian dari Agile."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Algorithm",
            tag: "Technology",
            pronunciation: "al-go-ri-thum",
            meaningEN: "A step-by-step procedure for solving a problem",
            meaningID: "Prosedur langkah demi langkah untuk menyelesaikan masalah",
            practiceSentencesEN: [
                "The algorithm processes data efficiently.",
                "We optimized the search algorithm.",
                "Sorting uses a custom algorithm.",
            ],
            practiceSentencesID: [
                "Algoritma memproses data dengan efisien.",
                "Kami mengoptimalkan algoritma pencarian.",
                "Penyortiran menggunakan algoritma khusus."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Backlog",
            tag: "Technology",
            pronunciation: "bak-log",
            meaningEN: "A list of pending tasks or features",
            meaningID: "Daftar tugas atau fitur yang belum dikerjakan",
            practiceSentencesEN: [
                "Tasks are stored in the backlog.",
                "We refine the backlog weekly.",
                "The backlog guides development."
            ],
            practiceSentencesID: [
                "Tugas disimpan di backlog.",
                "Kami memperbarui backlog setiap minggu.",
                "Backlog menjadi panduan pengembangan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Bug",
            tag: "Technology",
            pronunciation: "bug",
            meaningEN: "An error or flaw in software",
            meaningID: "Kesalahan atau cacat dalam perangkat lunak",
            practiceSentencesEN: [
                "A bug caused a crash.",
                "We fixed the login bug.",
                "QA found a UI bug."
            ],
            practiceSentencesID: [
                "Bug menyebabkan aplikasi crash.",
                "Kami memperbaiki bug login.",
                "QA menemukan bug pada UI."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Debug",
            tag: "Technology",
            pronunciation: "dee-bug",
            meaningEN: "To fix errors in code",
            meaningID: "Memperbaiki kesalahan dalam kode",
            practiceSentencesEN: [
                "We debug the issue.",
                "Debugging takes time.",
                "Logs help debug."
            ],
            practiceSentencesID: [
                "Kami melakukan debug pada masalah tersebut.",
                "Proses debugging membutuhkan waktu.",
                "Log membantu proses debug."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Deployment",
            tag: "Technology",
            pronunciation: "de-ploy-ment",
            meaningEN: "Releasing software to production",
            meaningID: "Proses merilis aplikasi ke lingkungan produksi",
            practiceSentencesEN: [
                "Deployment is scheduled after tests pass.",
                "We automated deployment.",
                "We monitored after deployment."
            ],
            practiceSentencesID: [
                "Deployment dijadwalkan setelah semua tes lulus.",
                "Kami mengotomatisasi deployment.",
                "Kami memantau sistem setelah deployment."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Development",
            tag: "Technology",
            pronunciation: "de-vel-up-ment",
            meaningEN: "The process of creating software",
            meaningID: "Proses pembuatan perangkat lunak",
            practiceSentencesEN: [
                "Development started after planning.",
                "We follow agile development.",
                "Mobile development needs testing."
            ],
            practiceSentencesID: [
                "Pengembangan dimulai setelah perencanaan.",
                "Kami mengikuti metode agile development.",
                "Pengembangan mobile membutuhkan pengujian."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Feature",
            tag: "Technology",
            pronunciation: "fee-cher",
            meaningEN: "A distinct function of a product",
            meaningID: "Fungsi atau fitur khusus dalam produk",
            practiceSentencesEN: [
                "We added a new feature.",
                "Each feature is tested.",
                "Users requested this feature."
            ],
            practiceSentencesID: [
                "Kami menambahkan fitur baru.",
                "Setiap fitur diuji terlebih dahulu.",
                "Pengguna meminta fitur ini."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Framework",
            tag: "Technology",
            pronunciation: "frame-work",
            meaningEN: "A platform for developing software",
            meaningID: "Kerangka kerja untuk pengembangan perangkat lunak",
            practiceSentencesEN: [
                "We used a framework.",
                "The framework speeds up development.",
                "Choosing framework is important."
            ],
            practiceSentencesID: [
                "Kami menggunakan framework.",
                "Framework mempercepat pengembangan.",
                "Memilih framework itu penting."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Function",
            tag: "Technology",
            pronunciation: "funk-shun",
            meaningEN: "A block of reusable code",
            meaningID: "Blok kode yang dapat digunakan kembali",
            practiceSentencesEN: [
                "This function handles login.",
                "We created a function.",
                "Each function has a purpose."
            ],
            practiceSentencesID: [
                "Fungsi ini menangani login.",
                "Kami membuat sebuah fungsi.",
                "Setiap fungsi memiliki tujuan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Integration",
            tag: "Technology",
            pronunciation: "in-te-gray-shun",
            meaningEN: "Combining systems together",
            meaningID: "Menggabungkan beberapa sistem",
            practiceSentencesEN: [
                "API integration connects services.",
                "We tested integration.",
                "Integration improves systems."
            ],
            practiceSentencesID: [
                "Integrasi API menghubungkan layanan.",
                "Kami menguji integrasi.",
                "Integrasi meningkatkan sistem."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Iteration",
            tag: "Technology",
            pronunciation: "i-ter-ay-shun",
            meaningEN: "Repeating a process",
            meaningID: "Pengulangan proses",
            practiceSentencesEN: [
                "Each iteration improves product.",
                "We work in iterations.",
                "Iteration refines features."
            ],
            practiceSentencesID: [
                "Setiap iterasi meningkatkan produk.",
                "Kami bekerja dalam iterasi.",
                "Iterasi menyempurnakan fitur."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Maintenance",
            tag: "Technology",
            pronunciation: "main-te-nans",
            meaningEN: "Updating and fixing software",
            meaningID: "Memperbarui dan memperbaiki perangkat lunak",
            practiceSentencesEN: [
                "Maintenance keeps the system stable.",
                "We perform regular code maintenance.",
                "Maintenance fixes bugs and improves performance."
            ],
            practiceSentencesID: [
                "Maintenance menjaga sistem tetap stabil.",
                "Kami melakukan maintenance kode secara rutin.",
                "Maintenance memperbaiki bug dan meningkatkan performa."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Monitoring",
            tag: "Technology",
            pronunciation: "mon-i-ter-ing",
            meaningEN: "Observing system performance",
            meaningID: "Memantau performa sistem",
            practiceSentencesEN: [
                "We monitor servers.",
                "Monitoring detects issues.",
                "Monitoring runs 24/7."
            ],
            practiceSentencesID: [
                "Kami memantau server.",
                "Monitoring mendeteksi masalah.",
                "Monitoring berjalan 24/7."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Optimization",
            tag: "Technology",
            pronunciation: "op-ti-mi-zay-shun",
            meaningEN: "Improving efficiency",
            meaningID: "Proses meningkatkan efisiensi",
            practiceSentencesEN: [
                "Optimization improved speed.",
                "We optimized queries.",
                "Optimization reduces cost."
            ],
            practiceSentencesID: [
                "Optimasi meningkatkan kecepatan.",
                "Kami mengoptimalkan query.",
                "Optimasi mengurangi biaya."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Performance",
            tag: "Technology",
            pronunciation: "per-for-mans",
            meaningEN: "How well a system works",
            meaningID: "Seberapa baik sistem bekerja",
            practiceSentencesEN: [
                "Performance improved.",
                "We tested performance.",
                "Performance is critical."
            ],
            practiceSentencesID: [
                "Performa meningkat.",
                "Kami menguji performa.",
                "Performa sangat penting."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Pipeline",
            tag: "Technology",
            pronunciation: "pipe-line",
            meaningEN: "Automated workflow process",
            meaningID: "Proses kerja otomatis",
            practiceSentencesEN: [
                "Pipeline runs tests.",
                "CI/CD pipeline works.",
                "We improved pipeline."
            ],
            practiceSentencesID: [
                "Pipeline menjalankan tes.",
                "Pipeline CI/CD berjalan.",
                "Kami meningkatkan pipeline."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Refactor",
            tag: "Technology",
            pronunciation: "ree-fak-ter",
            meaningEN: "Restructuring code without changing behavior",
            meaningID: "Menyusun ulang kode tanpa mengubah perilakunya",
            practiceSentencesEN: [
                "We refactor code to improve readability.",
                "Refactoring helps reduce technical debt.",
                "The team refactored the API layer for clarity."
            ],
            practiceSentencesID: [
                "Kami melakukan refactor pada kode untuk meningkatkan keterbacaan.",
                "Refactoring membantu mengurangi utang teknis.",
                "Tim melakukan refactor pada layer API agar lebih jelas."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Repository",
            tag: "Technology",
            pronunciation: "ree-pos-i-tor-ee",
            meaningEN: "Storage for code",
            meaningID: "Tempat penyimpanan kode",
            practiceSentencesEN: [
                "Code is in repository.",
                "We pushed code.",
                "Each project has repo."
            ],
            practiceSentencesID: [
                "Kode ada di repository.",
                "Kami push kode.",
                "Setiap proyek punya repo."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Scalability",
            tag: "Technology",
            pronunciation: "skay-la-bi-li-tee",
            meaningEN: "Ability to handle growth",
            meaningID: "Kemampuan sistem untuk menangani pertumbuhan",
            practiceSentencesEN: [
                "Scalability is important.",
                "System scales well.",
                "We improved scalability."
            ],
            practiceSentencesID: [
                "Scalability itu penting.",
                "Sistem dapat berkembang dengan baik.",
                "Kami meningkatkan scalability."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Security",
            tag: "Technology",
            pronunciation: "si-kyu-ri-tee",
            meaningEN: "Protection from threats",
            meaningID: "Perlindungan dari ancaman",
            practiceSentencesEN: [
                "Security is critical.",
                "We improved security.",
                "Security audit done."
            ],
            practiceSentencesID: [
                "Keamanan sangat penting.",
                "Kami meningkatkan keamanan.",
                "Audit keamanan dilakukan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Server",
            tag: "Technology",
            pronunciation: "ser-ver",
            meaningEN: "A machine providing services",
            meaningID: "Mesin yang menyediakan layanan",
            practiceSentencesEN: [
                "Server handles requests.",
                "We use cloud server.",
                "Server was down."
            ],
            practiceSentencesID: [
                "Server menangani permintaan.",
                "Kami menggunakan server cloud.",
                "Server sempat down."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Sprint",
            tag: "Technology",
            pronunciation: "sprint",
            meaningEN: "Short development cycle",
            meaningID: "Siklus pengembangan singkat",
            practiceSentencesEN: [
                "Sprint lasts two weeks.",
                "We plan sprint.",
                "Sprint review done."
            ],
            practiceSentencesID: [
                "Sprint berlangsung dua minggu.",
                "Kami merencanakan sprint.",
                "Review sprint dilakukan."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Testing",
            tag: "Technology",
            pronunciation: "tes-ting",
            meaningEN: "Checking for errors",
            meaningID: "Proses pengecekan kesalahan",
            practiceSentencesEN: [
                "Testing ensures quality.",
                "We run tests.",
                "Testing finds bugs."
            ],
            practiceSentencesID: [
                "Testing memastikan kualitas.",
                "Kami menjalankan tes.",
                "Testing menemukan bug."
            ],
            learnHistory: []
        ),
        Vocabulary(
            word: "Throughput",
            tag: "Technology",
            pronunciation: "throo-put",
            meaningEN: "Amount of work processed",
            meaningID: "Jumlah pekerjaan yang diproses",
            practiceSentencesEN: [
                "Throughput increased.",
                "System handles more.",
                "We optimized throughput."
            ],
            practiceSentencesID: [
                "Throughput meningkat.",
                "Sistem menangani lebih banyak.",
                "Kami mengoptimalkan throughput."
            ],
            learnHistory: []
        )
    ]
}
